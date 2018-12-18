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
        input [19:0] addr_a,
        // input we_a, clk,
        input we_a,
        output reg q_a
);

        reg [1048575:0] ram;


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
input[19:0] address_w,
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















