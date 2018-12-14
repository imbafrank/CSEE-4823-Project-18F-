`timescale 1ns / 1ps
// define `HALF_CLOCK_PERIOD  #5

module test_tb;

wire x_1 = 0;
reg clk = 0;
integer i;
reg x_reg = 1;
reg ctrl = 0;
reg [9:0] addr_counter = 0;
wire [9:0] addr_wire = 7;
wire [9:0] addr_input_wire ;
assign x_1 = x_reg;
assign addr_input_wire = ctrl? addr_counter : addr_wire;

always begin
  // `HALF_CLOCK_PERIOD;
  #5 clk = ~clk;
end

initial begin
	// #10 x_1 = 1;
	ctrl = 1;

	@(posedge clk);
	for (i=0; i<8; i=i+1) begin
		addr_counter = addr_counter + 1;
		@(posedge clk);
	end

	#10 ctrl = 0;
	$display("W1 finish loading.");
end

endmodule