//
//
//
//
`timescale 1ns/1ps

module lfsr1 (clk, i,j,write_enable,din,dout);
input clk,
	input wire [9:0] i,
	input wire [8:0] j,
	input write_enalbe,
	input wire [7:0] din,
	output reg [7:0] dout
	);

	reg 7:0] M[0:307199];
	wire [18:0] addr;
	
	assign addr = i*640 + j;


	always @(posedge clk) begin
	if (write_enable = 1'b1)
		M[addr] <= din;
	dout <= M[addr];
	end
endmodule


