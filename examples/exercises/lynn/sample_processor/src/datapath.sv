// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

module datapath(
        input   logic           clk, reset,
        input   logic [2:0]     Funct3,
        input   logic           ALUResultSrc, ResultSrc,
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
        input   logic [31:0]    ReadData
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

    alu alu(.SrcA, .SrcB, .ALUControl, .Funct3, .ALUResult, .IEUAdr);

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

    mux2 #(32) resultmux(IEUResult, LoadData, ResultSrc, Result);

    assign WriteData = R2;
endmodule
