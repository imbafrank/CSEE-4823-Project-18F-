
`timescale 1ns/1ps

module ctrl
    input clk, rst, read_weights_finish, read_inputs_finish, compute_finish;
    output ;
    // define states
    `define rest 0;
    `define read_weights 1;
    `define read_inputs 2;
    `define compute 3;
    // `define layer_1 ;
    // `define layer_2 ;
    // `define layer_3 ;
    // `define layer_4 ;
    // `define layer_5 ;

    // rest state counter
    reg [3:0] rest_counter;
    // state
    reg [2:0] state;
    // jump out rest state
    wire rest_finish;
    // start read weights
    reg start_read_w;
    // start read inputs
    reg start_read_i;
    // start compute layer1;
    reg start_compute;

    weight_ram
    (.start_read_w(start_read_w))

    input_ram
    (.start_read_i(start_read_i))

    cmp_module
    (	.start_compute(start_compute),
    	.compute_finish(compute_finish))




    // when rest 10 cycles, go to next state. 
    assign rest_finish = rest_counter>10;
    // FSM
    always @(posedge rst or posedge clk or )
    begin
    if rst begin
    	state <= rest;
    	rest_counter <= 4'd0;
    end

    else begin
    	case (state)
    	`rest:begin
    		if (rest_finish == 1) begin
    			state <= read_weights;
    			rest_counter <= 0;
    		end
    		else begin
    			rest_counter <= rest_counter + 1;
    			state <= rest;
    		end
    	end
    	`read_weights:begin
    		if (read_weights_finish == 1) begin
    			start_read_w <= 0;
    			state <= `read_inputs;
    		end
    		else begin
    			start_read_w <= 1
    			state <= `read_weights;
    		end
    	end
    	`read_inputs:begin
    		if (read_inputs_finish == 1) begin
    			start_read_i <= 0;
    			state <= `compute;
    		end
    		else begin
    			start_read_i <= 1;
    			state <= `read_inputs;
    		end
    	end
    	`compute:begin
    		if (compute_finish == 1) begin
    			start_compute <= 0;
    			state <= `output;
    		end
    		else begin
    			start_compute <= 1;
    			state <= `compute;
    		end
     	end

    end

    end
endmodule