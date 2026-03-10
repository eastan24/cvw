// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

module datapath(
        input   logic           clk, reset,
        input   logic [2:0]     Funct3,
        input   logic           ALUResultSrc, ResultSrc, CSRSrc,
        input   logic [1:0]     ALUSrc,
        input   logic           RegWrite,
        input   logic [2:0]     ImmSrc,
        input   logic [1:0]     ALUControl,
        output  logic           Eq,
        output  logic           Lt,
        output  logic           Ltu,
        input   logic [31:0]    PC, PCPlus4,
        input   logic [31:0]    Instr,
        output  logic [31:0]    IEUAdr, WriteData,
        input   logic [31:0]    ReadData,
        input   logic           IsAdd,
        input   logic           IsBranch,
        input   logic           BranchTaken
    );

    logic [31:0] ImmExt;
    logic [31:0] R1, R2, SrcA, SrcB;
    logic [31:0] ALUResult, IEUResult, Result;

    // register file logic
    regfile rf(.clk, .WE3(RegWrite), .A1(Instr[19:15]), .A2(Instr[24:20]),
        .A3(Instr[11:7]), .WD3(Result), .RD1(R1), .RD2(R2));

    extend ext(.Instr(Instr[31:7]), .ImmSrc, .ImmExt);

    // ALU logic
    cmp cmp(.R1(R1), .R2(R2), .Eq(Eq), .Lt(Lt), .Ltu(Ltu));

    mux2 #(32) srcamux(R1, PC, ALUSrc[1], SrcA);
    mux2 #(32) srcbmux(R2, ImmExt, ALUSrc[0], SrcB);

    alu alu(.SrcA, .SrcB, .ALUControl, .Funct3, .Funct7b0(Instr[25] & Instr[5]), .ALUResult, .IEUAdr);

    logic [31:0] PreIEUResult;

    mux2 #(32) ieuresultmux(ALUResult, PCPlus4, ALUResultSrc, PreIEUResult);

    // If LUI → bypass ALU and use ImmExt
    assign IEUResult = (Instr[6:0] == 7'b0110111) ? ImmExt : PreIEUResult;

    logic [31:0] LoadData;

    always_comb begin
        case (Funct3)

            3'b000: begin // LB
                case (ALUResult[1:0])
                    2'b00: LoadData = {{24{ReadData[7]}},  ReadData[7:0]};
                    2'b01: LoadData = {{24{ReadData[15]}}, ReadData[15:8]};
                    2'b10: LoadData = {{24{ReadData[23]}}, ReadData[23:16]};
                    2'b11: LoadData = {{24{ReadData[31]}}, ReadData[31:24]};
                endcase
            end

            3'b100: begin // LBU
                case (ALUResult[1:0])
                    2'b00: LoadData = {24'b0, ReadData[7:0]};
                    2'b01: LoadData = {24'b0, ReadData[15:8]};
                    2'b10: LoadData = {24'b0, ReadData[23:16]};
                    2'b11: LoadData = {24'b0, ReadData[31:24]};
                endcase
            end

            3'b001: begin // LH
                case (ALUResult[1])
                    1'b0: LoadData = {{16{ReadData[15]}}, ReadData[15:0]};
                    1'b1: LoadData = {{16{ReadData[31]}}, ReadData[31:16]};
                endcase
            end

            3'b101: begin // LHU
                case (ALUResult[1])
                    1'b0: LoadData = {16'b0, ReadData[15:0]};
                    1'b1: LoadData = {16'b0, ReadData[31:16]};
                endcase
            end

            default: LoadData = ReadData; // LW
        endcase
    end

    // CSR Register File
    logic [63:0] cycle_count;
    logic [63:0] instret_count;
    logic [63:0] hpm3_count;  // add instructions
    logic [63:0] hpm4_count;  // branches evaluated
    logic [63:0] hpm5_count;  // branches taken
    logic [63:0] hpm6_count;  // stores executed
    logic [63:0] hpm7_count;  // loads executed
    logic [63:0] hpm8_count;  // jal/jalr executed
    logic [63:0] hpm9_count;  // lui/auipc executed
    logic [63:0] hpm10_count; // CSR reads

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            cycle_count   <= 64'b0;
            instret_count <= 64'b0;
            hpm3_count    <= 64'b0;
            hpm4_count    <= 64'b0;
            hpm5_count    <= 64'b0;
            hpm6_count    <= 64'b0;
            hpm7_count    <= 64'b0;
            hpm8_count    <= 64'b0;
            hpm9_count    <= 64'b0;
            hpm10_count   <= 64'b0;
        end else begin
            cycle_count   <= cycle_count + 1;
            instret_count <= instret_count + 1;
            if (IsAdd)        hpm3_count  <= hpm3_count + 1;
            if (IsBranch)     hpm4_count  <= hpm4_count + 1;
            if (BranchTaken)  hpm5_count  <= hpm5_count + 1;
            if (Instr[6:0] == 7'b0100011) hpm6_count  <= hpm6_count + 1;  // stores
            if (Instr[6:0] == 7'b0000011) hpm7_count  <= hpm7_count + 1;  // loads
            if (Instr[6:0] == 7'b1101111 || Instr[6:0] == 7'b1100111) hpm8_count <= hpm8_count + 1; // jal/jalr
            if (Instr[6:0] == 7'b0110111 || Instr[6:0] == 7'b0010111) hpm9_count <= hpm9_count + 1; // lui/auipc
            if (Instr[6:0] == 7'b1110011) hpm10_count <= hpm10_count + 1; // CSR reads
        end
    end

    logic [31:0] CSRData;

    always_comb begin
        case (Instr[31:20])
            12'hC00: CSRData = cycle_count[31:0];   // rdcycle
            12'hC01: CSRData = cycle_count[31:0];   // rdtime (same as cycle)
            12'hC02: CSRData = instret_count[31:0]; // rdinstret
            12'hC03: CSRData = hpm3_count[31:0];
            12'hC04: CSRData = hpm4_count[31:0];
            12'hC05: CSRData = hpm5_count[31:0];
            12'hC06: CSRData = hpm6_count[31:0];
            12'hC07: CSRData = hpm7_count[31:0];
            12'hC08: CSRData = hpm8_count[31:0];
            12'hC09: CSRData = hpm9_count[31:0];
            12'hC0A: CSRData = hpm10_count[31:0];
            12'hC80: CSRData = cycle_count[63:32];  // rdcycleh
            12'hC81: CSRData = cycle_count[63:32];  // rdtimeh
            12'hC82: CSRData = instret_count[63:32];// rdinstreth
            12'hC83: CSRData = hpm3_count[63:32];
            12'hC84: CSRData = hpm4_count[63:32];
            12'hC85: CSRData = hpm5_count[63:32];
            12'hC86: CSRData = hpm6_count[63:32];
            12'hC87: CSRData = hpm7_count[63:32];
            12'hC88: CSRData = hpm8_count[63:32];
            12'hC89: CSRData = hpm9_count[63:32];
            12'hC8A: CSRData = hpm10_count[63:32];
            default:  CSRData = 32'b0;
        endcase
    end

    // Result mux
    logic [31:0] LoadOrIEUResult;
    mux2 #(32) resultmux(IEUResult, LoadData, ResultSrc, LoadOrIEUResult);
    assign Result = CSRSrc ? CSRData : LoadOrIEUResult;

    always_comb begin
        case (Funct3)
            3'b000: begin // SB - replicate byte to all lanes
                WriteData = {R2[7:0], R2[7:0], R2[7:0], R2[7:0]};
            end
            3'b001: begin // SH - replicate halfword to both lanes
                WriteData = {R2[15:0], R2[15:0]};
            end
            default: WriteData = R2; // SW
        endcase
    end
endmodule
