`timescale 1ns / 1ps
`define rst 0
`define load_x1 1
// `define store_x 2
`define check_load_addr_x1 2
`define update_load_addr_x1 3
`define store_x2_preset 4
`define store_x2_write 5
`define store_x2_finish 6
`define check_store_addr_x2 7
`define update_store_addr_x2 8
`define load_x2 9
`define check_load_addr_x2 10
`define update_load_addr_x2 11
`define store_x3_preset 12
`define store_x3_write 13
`define store_x3_finish 14
`define check_store_addr_x3 15
`define update_store_addr_x3 16
`define load_x3 17
`define check_load_addr_x3 18
`define update_load_addr_x3 19
`define store_x4_preset 20
`define store_x4_write 21
`define store_x4_finish 22
`define check_store_addr_x4 23
`define update_store_addr_x4 24
`define load_x4 25
`define check_load_addr_x4 26
`define update_load_addr_x4 27
`define display_x5 28
`define check_store_addr_x5 29
`define update_store_addr_x5 30
// `define store_x 2
// `define update_load_addr_x2 8
// `define check_load_addr_x2 9
// `define store_x3 10
// `define update_store_addr_x3 11
// `define check_store_addr_x3 12

module compute_module
#(
	parameter W_ADDR_LEN = 10,
	parameter W_DATA_LEN = 1,
	parameter W_SEL_LEN = 2,
	parameter W_RW_LEN = 2,
	parameter X_ADDR_LEN = 10,
	parameter X_DATA_LEN = 1,
	parameter X_SEL_LEN = 2,
	parameter X_RW_LEN = 2,
//	 parameter W1_LEN = 802816,
//	 parameter X1_LEN = 784,
///	 parameter W2_LEN = 1048576,
//	 parameter X2_LEN = 1024,
//	 parameter W3_LEN = 1048576,
//	 parameter X3_LEN = 1024,
//	 parameter W4_LEN = 10240,
//	 parameter X4_LEN = 1024,
//	 parameter X5_LEN = 10,
	// small nn test
	parameter W1_LEN = 6,
	parameter X1_LEN = 2,
	parameter W2_LEN = 9,
	parameter X2_LEN = 3,
parameter W3_LEN = 9,
	parameter X3_LEN = 3,
	parameter W4_LEN = 6,
	parameter X4_LEN = 3,
	parameter X5_LEN = 2,

	parameter OUTPUT_LEN = 10,
	parameter alu_width  = 13
	)
(
	clk,
	// rst,
	// control
	en,
	compute_finish,
	// connect to mem
	wx_write,
	w_addr,
	w_data,
	w_sel,
	// w_rq,
	w_wq,
	x_addr,
	x_data,
	x_sel,
	// x_rq,
	x_wq
	);

input clk, en;
input [W_DATA_LEN-1:0] w_data;
input [X_DATA_LEN-1:0] x_data;

output reg compute_finish;

output reg wx_write;

output wire [W_ADDR_LEN-1:0] w_addr;
output reg [W_SEL_LEN-1:0] w_sel;
output reg w_wq;

output wire [X_ADDR_LEN-1:0] x_addr;
output reg [X_SEL_LEN-1:0] x_sel;
output reg x_wq;

// reg calc_rst;
// wire calc_1;
wire calc_in;
// wire [alu_width-1:0] agg_out2alu;
// wire agg_out_acted;

reg r_or_w;
// reg agg_out_reg;

reg [5:0] state;

// integer display_output;

// reg layer1_finish;
reg compute_finish;


reg [W_ADDR_LEN-1:0] load_weight_counter;
reg [X_ADDR_LEN-1:0] load_x_counter;
reg [X_ADDR_LEN-1:0] store_x_counter;

reg signed [alu_width-1:0] store_x;

assign w_addr = load_weight_counter;
assign x_addr = r_or_w? load_x_counter : store_x_counter;
// assign calc_1 = 1;
assign calc_in = w_data ^ x_data;

//  calc calc_i
// (
// 	.clk(clk),
// 	.rst(calc_rst),
// 	.calc_1(calc_1),
// 	.calc_in(calc_in),
// 	.agg_out2alu(agg_out2alu),
// 	.agg_out_acted(agg_out_acted));

always @(posedge clk) begin
	if (en==0) begin
		state <= `rst;
		wx_write <= 0;
		w_wq <= 0;
		x_wq <= 0;
		load_weight_counter <= 0;
		load_x_counter <= 0;
		store_x_counter <= 0;
		w_sel <= 0;
		x_sel <= 0;
		// agg_out_reg <= 0;
		// layer1_finish <= 0;
		// calc_rst <= 1;
		compute_finish <= 0;
		store_x <= 0;
		r_or_w <= 1;
		compute_finish <= 0;

	end
	else begin
		case (state)
		`rst: begin
			state <= `load_x1;
			// w_wq <= 0;
			// x_wq <= 0;
			// load_weight_counter <= 0;
			// load_x_counter <= 0;
			// store_x_counter <= 0;
			// w_sel <= 0;
			// x_sel <= 0;
			// agg_out_reg <= 0;
			// layer1_finish <= 0;
			// calc_rst <= 1;
			// compute_finish <= 0;
			// store_x <= 0;
			// r_or_w <= 1;

		end

		// layer1
// -----------------------------------------------
		`load_x1: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x1;

		end


		`check_load_addr_x1: begin
			if (load_x_counter >= X1_LEN-1) begin
				state <= `store_x2_preset;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x1;
			end
		end

		`update_load_addr_x1: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x1;

		end

		`store_x2_preset: begin
			x_sel <= 1;
			r_or_w <= 0;
			// x_wq <= 1;
			state <= `store_x2_write;
			wx_write <= !store_x[alu_width-1];
		end

		`store_x2_write: begin
			x_wq <= 1;
			state <= `store_x2_finish;
		end

		`store_x2_finish: begin
			x_wq <= 0;
			state <= `check_store_addr_x2;
		end


		`check_store_addr_x2: begin
			// x_sel <= 0;
			r_or_w <= 1;
			if (store_x_counter>=X2_LEN-1) begin
				// $finish;
				state <= `load_x2;
				load_weight_counter <= 0;
				load_x_counter <= 0;
				store_x_counter <= 0;
				w_sel <= 1;
				x_sel <= 1;
				store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x2;
				store_x <= 0;
				x_sel <= 0;
			end
		end

		`update_store_addr_x2: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x1;
		end


		// layer 2
// --------------------------------------------------------

		`load_x2: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x2;

		end


		`check_load_addr_x2: begin
			if (load_x_counter >= X2_LEN-1) begin
				state <= `store_x3_preset;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x2;
			end
		end

		`update_load_addr_x2: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x2;

		end

		`store_x3_preset: begin
			x_sel <= 2;
			r_or_w <= 0;
			// x_wq <= 1;
			state <= `store_x3_write;
			wx_write <= !store_x[alu_width-1];
		end

		`store_x3_write: begin
			x_wq <= 1;
			state <= `store_x3_finish;
		end

		`store_x3_finish: begin
			x_wq <= 0;
			state <= `check_store_addr_x3;
		end


		`check_store_addr_x3: begin
			x_sel <= 1;
			r_or_w <= 1;
			if (store_x_counter>=X3_LEN-1) begin
				// $finish;
				state <= `load_x3;
				load_weight_counter <= 0;
				load_x_counter <= 0;
				store_x_counter <= 0;
				w_sel <= 2;
				x_sel <= 2;
				store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x3;
				store_x <= 0;
			end
		end

		`update_store_addr_x3: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x2;
		end


		// layer 3
// --------------------------------------------------------

		`load_x3: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x3;

		end


		`check_load_addr_x3: begin
			if (load_x_counter >= X3_LEN-1) begin
				state <= `store_x4_preset;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x3;
			end
		end

		`update_load_addr_x3: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x3;

		end

		`store_x4_preset: begin
			x_sel <= 3;
			r_or_w <= 0;
			// x_wq <= 1;
			state <= `store_x4_write;
			wx_write <= !store_x[alu_width-1];
		end

		`store_x4_write: begin
			x_wq <= 1;
			state <= `store_x4_finish;
		end

		`store_x4_finish: begin
			x_wq <= 0;
			state <= `check_store_addr_x4;
		end


		`check_store_addr_x4: begin
			x_sel <= 2;
			r_or_w <= 1;
			if (store_x_counter>=X4_LEN-1) begin
				// $finish;
				state <= `load_x4;
				load_weight_counter <= 0;
				load_x_counter <= 0;
				store_x_counter <= 0;
				w_sel <= 3;
				x_sel <= 3;
				store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x4;
				store_x <= 0;
			end
		end

		`update_store_addr_x4: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x3;
		end


		// layer 4
// --------------------------------------------------------

		`load_x4: begin
			if (calc_in==0) begin
				store_x <= store_x + 1;
			end
			else begin
				store_x <= store_x -1;
			end
			state <= `check_load_addr_x4;

		end


		`check_load_addr_x4: begin
			if (load_x_counter >= X4_LEN-1) begin
				state <= `display_x5;
				load_x_counter <= 0;
				load_weight_counter <= load_weight_counter + 1;
			end
			else begin
				state<=`update_load_addr_x4;
			end
		end

		`update_load_addr_x4: begin
			load_weight_counter <= load_weight_counter + 1;
			load_x_counter <= load_x_counter + 1;
			state <= `load_x4;

		end

		`display_x5: begin
			// x_sel <= 3;
			// r_or_w <= 0;
			// x_wq <= 1;
			state <= `check_store_addr_x5;
			wx_write <= !store_x[alu_width-1];
			// display_output <= wx_wirte;
			//$display("%b",wx_write);
		end

		// `store_x4_write: begin
		// 	x_wq <= 1;
		// 	state <= `store_x4_finish;
		// end

		// `store_x4_finish: begin
		// 	x_wq <= 0;
		// 	state <= `check_store_addr_x4;
		// end


		`check_store_addr_x5: begin
			x_sel <= 3;
			r_or_w <= 1;
			if (store_x_counter>=X5_LEN-1) begin
				compute_finish <= 1;				
				//$finish;
				// state <= `load_x4;
				// load_weight_counter <= 0;
				// load_x_counter <= 0;
				// store_x_counter <= 0;
				// w_sel <= 3;
				// x_sel <= 3;
				// store_x <= 0;
			end
			else begin
				state <= `update_store_addr_x5;
				store_x <= 0;
			end
		end

		`update_store_addr_x5: begin
		// synthesis probably goes wrong here!!!
			// x_sel <= 0;
			// x_wq <= 0;
			// r_or_w <= 1;
			store_x_counter <= store_x_counter + 1;
			state <= `load_x4;
		end



		endcase
	end
end

endmodule


module demux1to4(
     Data_in,
     sel,
    Data_out_0,
    Data_out_1,
    Data_out_2,
    Data_out_3
    );

    input Data_in;
    input [1:0] sel;

    output Data_out_0;
    output Data_out_1;
    output Data_out_2;
    output Data_out_3;

    reg Data_out_0;
    reg Data_out_1;
    reg Data_out_2;
    reg Data_out_3;

    always @(Data_in or sel)
    begin
        case (sel)
            2'b00 : begin
                        Data_out_0 = Data_in;
                        Data_out_1 = 0;
                        Data_out_2 = 0;
                        Data_out_3 = 0;
                      end
            2'b01 : begin
                        Data_out_0 = 0;
                        Data_out_1 = Data_in;
                        Data_out_2 = 0;
                        Data_out_3 = 0;
                      end
            2'b10 : begin
                        Data_out_0 = 0;
                        Data_out_1 = 0;
                        Data_out_2 = Data_in;
                        Data_out_3 = 0;
                      end
            2'b11 : begin
                        Data_out_0 = 0;
                        Data_out_1 = 0;
                        Data_out_2 = 0;
                        Data_out_3 = Data_in;
                      end
        endcase
    end

endmodule
//...........................................................................
module mux4to1(Y, A, B, C, D, sel);
     output   Y;
     input    A, B, C, D;
     input[1:0]     sel;
     reg     Y;
     always @(A or B or C or D or sel) 
       case ( sel )
         2'b00:   Y = A;
         2'b01:   Y = B;
         2'b10:   Y = C;
         2'b11:   Y = D;
         default: Y = 1'bx;
       endcase
endmodule
//............................................................................
module mem_small
(
	input data_a,
	input [9:0] addr_a,
	// input we_a, clk,
    input we_a,
	output reg q_a
);
	
	reg [1023:0] ram;
	
	
	always @ (*)
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
//...........................................................................
module mem_large
(
        input data_a,
        input [9:0] addr_a,
        // input we_a, clk,
        input we_a,
        output reg q_a
);

        reg [1023:0] ram;


        always @ (*)
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
//............................................................................
//............................................................................
//.............................................................................

module mem_sys(
// input clk,
input we_x,
input we_w,
input data_in,
output data_out_x,
output data_out_w,
input[9:0] address_x,
input[9:0] address_w,
input[1:0] sel_x,
input[1:0] sel_w
);


wire we_x1;
wire we_x2;
wire we_x3;
wire we_x4;

wire we_w1;
wire we_w2;
wire we_w3;
wire we_w4;

wire data_in_x1;
wire data_in_x2;
wire data_in_x3;
wire data_in_x4;

wire data_in_w1;
wire data_in_w2;
wire data_in_w3;
wire data_in_w4;

wire data_out_x1;
wire data_out_x2;
wire data_out_x3;
wire data_out_x4;

wire data_out_w1;
wire data_out_w2;
wire data_out_w3;
wire data_out_w4;

mem_small mem_x1(
    .data_a(data_in_x1),
    .addr_a(address_x),
    // .clk(clk),
    .we_a(we_x1),
    .q_a(data_out_x1)
);

mem_small mem_x2(
    .data_a(data_in_x2),
    .addr_a(address_x),
    // .clk(clk),
    .we_a(we_x2),
    .q_a(data_out_x2)
);

mem_small mem_x3(
    .data_a(data_in_x3),
    .addr_a(address_x),
    // .clk(clk),
    .we_a(we_x3),
    .q_a(data_out_x3)
);

mem_small mem_x4(
    .data_a(data_in_x4),
    .addr_a(address_x),
    // .clk(clk),
    .we_a(we_x4),
    .q_a(data_out_x4)
);

mem_large mem_w1(
    .data_a(data_in_w1),
    .addr_a(address_w),
    // .clk(clk),
    .we_a(we_w1),
    .q_a(data_out_w1)
);

mem_large mem_w2(
    .data_a(data_in_w2),
    .addr_a(address_w),
    // .clk(clk),
    .we_a(we_w2),
    .q_a(data_out_w2)
);

mem_large mem_w3(
    .data_a(data_in_w3),
    .addr_a(address_w),
    // .clk(clk),
    .we_a(we_w3),
    .q_a(data_out_w3)
);

mem_large mem_w4(
    .data_a(data_in_w4),
    .addr_a(address_w),
    // .clk(clk),
    .we_a(we_w4),
    .q_a(data_out_w4)
);


demux1to4 we_for_x(
    .Data_in(we_x),
    .sel(sel_x),
    .Data_out_0(we_x1),
    .Data_out_1(we_x2),
    .Data_out_2(we_x3),
    .Data_out_3(we_x4)
);

demux1to4 we_for_w(
    .Data_in(we_w),
    .sel(sel_w),
    .Data_out_0(we_w1),
    .Data_out_1(we_w2),
    .Data_out_2(we_w3),
    .Data_out_3(we_w4)
);

demux1to4 data_in_for_x(
    .Data_in(data_in),
    .sel(sel_x),
    .Data_out_0(data_in_x1),
    .Data_out_1(data_in_x2),
    .Data_out_2(data_in_x3),
    .Data_out_3(data_in_x4)
);

demux1to4 data_in_for_w(
    .Data_in(data_in),
    .sel(sel_w),
    .Data_out_0(data_in_w1),
    .Data_out_1(data_in_w2),
    .Data_out_2(data_in_w3),
    .Data_out_3(data_in_w4)
);

mux4to1 data_out_for_x(
    .Y(data_out_x),
    .sel(sel_x),
    .A(data_out_x1),
    .B(data_out_x2),
    .C(data_out_x3),
    .D(data_out_x4)

);

mux4to1 data_out_for_w(
    .Y(data_out_w),
    .sel(sel_w),
    .A(data_out_w1),
    .B(data_out_w2),
    .C(data_out_w3),
    .D(data_out_w4)

);



endmodule




































module mnist_nn
#(
	parameter W_ADDR_LEN = 10,
	parameter W_DATA_LEN = 1,
	parameter W_SEL_LEN = 2,
	// parameter W_RW_LEN = 2;
	parameter X_ADDR_LEN = 10,
	parameter X_DATA_LEN = 1,
	parameter X_SEL_LEN = 2)
	// parameter X_RW_LEN = 2;)
(
	clk,
	// rst,
	// rst_mem,
	load_compute_ctrl,
	en_compute,
	// oc means off chip
	w_wq_oc,
	x_wq_oc,
	w_addr_oc,
	x_addr_oc,
	wx_write_oc,
	//x_data_oc,
	//w_data_oc,
	x_sel_oc,
	w_sel_oc,
	compute_finish
	);
input clk, load_compute_ctrl, en_compute;
input w_wq_oc, x_wq_oc;
input [W_ADDR_LEN-1:0] w_addr_oc;
input [X_ADDR_LEN-1:0] x_addr_oc;
input wx_write_oc;
//input w_data_oc;//[W_DATA_LEN-1:0] w_data_oc;
//input x_data_oc;//[X_DATA_LEN-1:0] x_data_oc;
input [W_SEL_LEN-1:0] w_sel_oc;
input [X_SEL_LEN-1:0] x_sel_oc;
output wire compute_finish;

wire w_wq_wire, x_wq_wire;
wire [W_ADDR_LEN-1:0] w_addr_wire;
wire [X_ADDR_LEN-1:0] x_addr_wire;
wire wx_write_wire;
//wire [W_DATA_LEN-1:0] w_data_wire;
//wire [X_DATA_LEN-1:0] x_data_wire;
wire [W_SEL_LEN-1:0] w_sel_wire;
wire [X_SEL_LEN-1:0] x_sel_wire;

wire w_wq, x_wq;
wire [W_ADDR_LEN-1:0] w_addr;
wire [X_ADDR_LEN-1:0] x_addr;
wire wx_write;
wire [W_DATA_LEN-1:0] w_data;
wire [X_DATA_LEN-1:0] x_data;
wire [W_SEL_LEN-1:0] w_sel;
wire [X_SEL_LEN-1:0] x_sel;

assign wx_write = load_compute_ctrl? wx_write_oc : wx_write_wire;
assign w_addr = load_compute_ctrl? w_addr_oc : w_addr_wire;
// assign w_data = load_compute_ctrl? w_data_oc : w_data_wire;
//assign w_data_wire = w_data;
assign w_sel = load_compute_ctrl? w_sel_oc : w_sel_wire;
assign w_wq = load_compute_ctrl? w_wq_oc : w_wq_wire;
assign x_addr = load_compute_ctrl? x_addr_oc : x_addr_wire;
// assign x_data = load_compute_ctrl? x_data_oc : x_data_wire;
//assign x_data_wire = x_data;
assign x_sel = load_compute_ctrl? x_sel_oc : x_sel_wire;
assign x_wq = load_compute_ctrl? x_wq_oc : x_wq_wire;

mem_sys mem_sys_i
(
	// .clk(clk),
	.we_w(w_wq),
	.we_x(x_wq),
	.address_w(w_addr),
	.address_x(x_addr),
	.data_in(wx_write),
	.data_out_x(x_data),
	.data_out_w(w_data),
	.sel_x(x_sel),
	.sel_w(w_sel)
	);

compute_module compute_module_i
(
	.clk(clk),
	// .rst(rst),
	.en(en_compute),
	.compute_finish(compute_finish),
	.wx_write(wx_write_wire),
	.w_addr(w_addr_wire),
	.w_data(w_data),
	.w_sel(w_sel_wire),
	.w_wq(w_wq_wire),
	.x_addr(x_addr_wire),
	.x_data(x_data),
	.x_sel(x_sel_wire),
	.x_wq(x_wq_wire)
	);


endmodule
