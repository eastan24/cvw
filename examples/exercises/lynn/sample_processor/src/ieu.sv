// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

`include "parameters.svh"

module ieu(
        input   logic           clk, reset,
        input   logic [31:0]    Instr,
        input   logic [31:0]    PC, PCPlus4,
        output  logic           PCSrc,
        output  logic [3:0]     WriteByteEn,
        output  logic [31:0]    IEUAdr, WriteData,
        input   logic [31:0]    ReadData,
        output  logic           MemEn
    );

    logic RegWrite, Jump, ALUResultSrc, ResultSrc, CSRSrc;
    logic Eq, Lt, Ltu;
    logic [1:0] ALUSrc;
    logic [2:0] ImmSrc;
    logic [1:0] ALUControl;
    logic MemWrite;
    logic IsAdd, IsBranch, BranchTaken;

    controller c(
        .Op(Instr[6:0]),
        .Eq(Eq),
        .Lt(Lt),
        .Ltu(Ltu),
        .Funct3(Instr[14:12]),
        .Funct7b5(Instr[30]),
        .ALUResultSrc(ALUResultSrc),
        .ResultSrc(ResultSrc),
        .CSRSrc(CSRSrc),
        .PCSrc(PCSrc),
        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .MemEn(MemEn),
        .MemWrite(MemWrite),
        .IsAdd(IsAdd),
        .IsBranch(IsBranch),
        .BranchTaken(BranchTaken)
    `ifdef DEBUG
        , .insn_debug(Instr)
    `endif
    );

    datapath dp(
        .clk(clk),
        .reset(reset),
        .Funct3(Instr[14:12]),
        .ALUResultSrc(ALUResultSrc),
        .ResultSrc(ResultSrc),
        .CSRSrc(CSRSrc),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
        .ImmSrc(ImmSrc),
        .ALUControl(ALUControl),
        .Eq(Eq),
        .Lt(Lt),
        .Ltu(Ltu),
        .PC(PC),
        .PCPlus4(PCPlus4),
        .Instr(Instr),
        .IEUAdr(IEUAdr),
        .WriteData(WriteData),
        .ReadData(ReadData),
        .IsAdd(IsAdd),
        .IsBranch(IsBranch),
        .BranchTaken(BranchTaken)
    );

    logic [3:0] StoreByteEn;

    always_comb begin
        StoreByteEn = 4'b0000;

        if (MemWrite) begin
            case (Instr[14:12])

                // SB
                3'b000: begin
                    case (IEUAdr[1:0])
                        2'b00: StoreByteEn = 4'b0001;
                        2'b01: StoreByteEn = 4'b0010;
                        2'b10: StoreByteEn = 4'b0100;
                        2'b11: StoreByteEn = 4'b1000;
                    endcase
                end

                // SH
                3'b001: begin
                    case (IEUAdr[1])
                        1'b0: StoreByteEn = 4'b0011;
                        1'b1: StoreByteEn = 4'b1100;
                    endcase
                end

                // SW
                3'b010: StoreByteEn = 4'b1111;

                default: StoreByteEn = 4'b0000;
            endcase
        end
    end


    assign WriteByteEn = StoreByteEn;
endmodule
