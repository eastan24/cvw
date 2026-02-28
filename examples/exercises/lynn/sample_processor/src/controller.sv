// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

`include "parameters.svh"

module controller(
        input   logic [6:0]   Op,
        input   logic         Eq,
        input   logic         Lt,
        input   logic         Ltu,
        input   logic [2:0]   Funct3,
        input   logic         Funct7b5,
        output  logic         ALUResultSrc,
        output  logic         ResultSrc,
        output  logic         PCSrc,
        output  logic         RegWrite,
        output  logic [1:0]   ALUSrc,
        output  logic [2:0]   ImmSrc,
        output  logic [1:0]   ALUControl,
        output  logic         MemEn,
        output  logic         MemWrite
    `ifdef DEBUG
        , input   logic [31:0]  insn_debug
    `endif
    );

    logic Branch, Jump;
    logic Sub, ALUOp;
    logic [12:0] controls;

    // Main decoder
    always_comb
        case(Op)
            // RegWrite_ImmSrc_ALUSrc_ALUOp_ALUResultSrc_MemWrite_ResultSrc_Branch_Jump_Load
            7'b0000011: controls = 13'b1_000_01_0_0_0_1_0_0_1; // lw
            7'b0100011: controls = 13'b0_001_01_0_0_1_0_0_0_1; // sw
            7'b0110011: controls = 13'b1_000_00_1_0_0_0_0_0_0; // R-type
            7'b0010011: controls = 13'b1_000_01_1_0_0_0_0_0_0; // I-type ALU
            7'b1100011: controls = 13'b0_010_11_0_0_0_0_1_0_0; // beq
            7'b1101111: controls = 13'b1_100_11_0_1_0_0_0_1_0; // jal
            7'b1100111: controls = 13'b1_000_01_0_1_0_0_0_1_0; // jalr
            7'b0110111: controls = 13'b1_011_01_0_0_0_0_0_0_0; // lui
            7'b0010111: controls = 13'b1_011_11_0_0_0_0_0_0_0; // auipc

            default: begin
                `ifdef DEBUG
                    controls = 13'b0; // non-implemented instruction
                    if ((insn_debug !== 'x)) begin
                        $display("Instruction not implemented: %h", insn_debug);
                        $finish(-1);
                    end
                `else
                    controls = 13'b0; // non-implemented instruction
                `endif
            end
        endcase

    assign {RegWrite, ImmSrc, ALUSrc, ALUOp, ALUResultSrc, MemWrite,
        ResultSrc, Branch, Jump, MemEn} = controls;

    // ALU Control Logic
    assign Sub = ALUOp & (
        ((Funct3 == 3'b000) & Funct7b5 & Op[5]) |  // SUB
        (Funct3 == 3'b010) |                      // SLT
        ((Funct3 == 3'b101) & Funct7b5)           // SRA / SRAI
    );
    assign ALUControl = {Sub, ALUOp};

    // PCSrc logic
    logic TakeBranch;

    always_comb begin
        TakeBranch = 1'b0;

        if (Branch) begin
            unique case (Funct3)
                3'b000: TakeBranch = Eq;      // BEQ
                3'b001: TakeBranch = ~Eq;     // BNE
                3'b100: TakeBranch = Lt;      // BLT  (signed)
                3'b101: TakeBranch = ~Lt;     // BGE  (signed)
                3'b110: TakeBranch = Ltu;     // BLTU (unsigned)
                3'b111: TakeBranch = ~Ltu;    // BGEU (unsigned)
                default: TakeBranch = 1'b0;
            endcase
        end
    end

    assign PCSrc = TakeBranch | Jump;
endmodule
