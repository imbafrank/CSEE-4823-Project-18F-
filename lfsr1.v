module mem_small
(
        input data_a,
        input [10:0] addr_a,
        input we_a, clk,
       output reg q_a
);
        
        reg [2048-1:0] ram;
        
        
        always @ (posedge clk)
        begin
                if (we_a) 
                begin
                        ram[addr_a] <= data_a;
                        q_a <= data_a;
                end
                else 
                begin
                        q_a <= ram[addr_a];
                end
        end
        
        
endmodule


module lfsr1(
 input clk,
 input data_a,
 input we_a,
 output q_a,
 input addr_a
);

	mem_small m1(
	.data_a(data_a),
	.clk(clk),
	.we_a(we_a),
	.q_a(q_a),
	.addr_a(addr_a)
	);

        mem_small m2(
        .data_a(data_a),
        .clk(clk),
        .we_a(we_a),
        .q_a(q_a),
        .addr_a(addr_a)
        );

        mem_small m3(
        .data_a(data_a),
        .clk(clk),
        .we_a(we_a),
        .q_a(q_a),
        .addr_a(addr_a)
        );
        mem_small m4(
        .data_a(data_a),
        .clk(clk),
        .we_a(we_a),
        .q_a(q_a),
        .addr_a(addr_a)
        );
        mem_small m5(
        .data_a(data_a),
        .clk(clk),
        .we_a(we_a),
        .q_a(q_a),
        .addr_a(addr_a)
        );
        mem_small m6(
        .data_a(data_a),
        .clk(clk),
        .we_a(we_a),
        .q_a(q_a),
        .addr_a(addr_a)
        );
endmodule
