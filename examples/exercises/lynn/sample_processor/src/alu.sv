// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

module alu(
        input   logic [31:0]    SrcA, SrcB,
        input   logic [1:0]     ALUControl,
        input   logic [2:0]     Funct3,
        input   logic           Funct7b0,
        output  logic [31:0]    ALUResult, IEUAdr
    );

    logic [31:0] CondInvb, Sum, SLT;
    logic ALUOp, Sub, Overflow, Neg, LT;
    logic [2:0] ALUFunct;

    // Multiply support (Zmmul)
    logic signed [63:0] MulResult;
    logic [63:0] MulResultU;
    logic signed [63:0] MulResultSU;
    logic IsMul;

    assign {Sub, ALUOp} = ALUControl;

    // Add or subtract
    assign CondInvb = Sub ? ~SrcB : SrcB;
    assign Sum = SrcA + CondInvb + {{(31){1'b0}}, Sub};
    assign IEUAdr = Sum; // Send this out to IFU and LSU

    // Set less than based on subtraction result
    assign Overflow = (SrcA[31] ^ SrcB[31]) & (SrcA[31] ^ Sum[31]);
    assign Neg = Sum[31];
    assign LT = Neg ^ Overflow;
    assign SLT = {31'b0, LT};
    assign ALUFunct = Funct3 & {3{ALUOp}}; // Force ALUFunct to 0 to Add when ALUOp = 0

    assign IsMul = Funct7b0 & ALUOp;
    assign MulResult   = $signed(SrcA) * $signed(SrcB);           // mul, mulh
    assign MulResultU  = {32'b0, SrcA} * {32'b0, SrcB};           // mulhu (unsigned x unsigned)
    assign MulResultSU = $signed({{32{SrcA[31]}}, SrcA}) * $signed({32'b0, SrcB}); // mulhsu (signed x unsigned)

    always_comb begin
        if (IsMul) begin
            case (Funct3)
                3'b000: ALUResult = MulResult[31:0];    // MUL
                3'b001: ALUResult = MulResult[63:32];   // MULH
                3'b010: ALUResult = MulResultSU[63:32]; // MULHSU
                3'b011: ALUResult = MulResultU[63:32];  // MULHU
                default: ALUResult = 32'b0;
            endcase
        end else begin
            case (ALUFunct)
                3'b000: ALUResult = Sum; // add or sub
                3'b010: ALUResult = SLT; // slt
                3'b011: ALUResult = {31'b0, (SrcA < SrcB)}; // SLTU
                3'b100: ALUResult = SrcA ^ SrcB; // xor
                3'b110: ALUResult = SrcA | SrcB; // or
                3'b111: ALUResult = SrcA & SrcB; // and
                3'b001: ALUResult = SrcA << SrcB[4:0]; // SLL
                3'b101: begin
                    if (Sub) // use Sub bit to detect SRA
                        ALUResult = $signed(SrcA) >>> SrcB[4:0]; // SRA
                    else
                        ALUResult = SrcA >> SrcB[4:0]; // SRL
                end

                default: ALUResult = 32'b0;
            endcase
        end
    end
endmodule
