// riscvsingle.sv
// RISC-V single-cycle processor
// David_Harris@hmc.edu 2020

module regfile(
        input   logic           clk,
        input   logic           WE3,
        input   logic [4:0]     A1, A2, A3,
        input   logic [31:0]    WD3,
        output  logic [31:0]    RD1, RD2
    );

    logic [31:0] rf[31:1];

    // three ported register file
    // read two ports combinationally (A1/RD1, A2/RD2)
    // write third port on rising edge of clock (A3/WD3/WE3)
    // register 0 hardwired to 0
    always_ff @(posedge clk) begin
        if (WE3 && (A3 != 5'd0)) rf[A3] <= WD3;
    end

    assign RD1 = (A1 != 5'd0) ? rf[A1] : 32'd0;
    assign RD2 = (A2 != 5'd0) ? rf[A2] : 32'd0;
endmodule
