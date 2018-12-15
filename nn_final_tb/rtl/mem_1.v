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





//..................................................................
module mem_small(
    clk,
    rst,
    read_rq,
    write_rq,
    rw_address,
    write_data,
    read_data,
    en
);
input		en;
input           clk;
input           rst;
input           read_rq;
input           write_rq;
input[9:0]      rw_address;
input      write_data;
output     read_data;

reg     read_data;
integer out, i;
reg [1023:0] memory_ram_d;
reg [1023:0] memory_ram_q;

always @(posedge clk or
    negedge rst)
begin
    if (!rst)
    begin
        for (i=0;i<1024; i=i+1)
            memory_ram_q[i] <= 0;
    end
    // else
    // begin
    //     for (i=0;i<1024; i=i+1)
    //          memory_ram_q[i] <= memory_ram_d[i];
    // end
end


// always @(*)
// begin
//     for (i=0;i<1024; i=i+1)
//         memory_ram_d[i] = memory_ram_q[i];
//     if (write_rq && !read_rq && en)
//         memory_ram_d[rw_address] = write_data;
//     if (!write_rq && read_rq && en)
//         read_data = memory_ram_q[rw_address];
//     else 
//         read_data = 1'bz;
// end

endmodule

//...................................................
module mem_large(
    clk,
    rst,
    read_rq,
    write_rq,
    rw_address,
    write_data,
    read_data,
    en
);
input 		en;
input           clk;
input           rst;
input           read_rq;
input           write_rq;
input[19:0]     rw_address;
input	        write_data;
output	        read_data;

reg             read_data;

integer out, i;
reg [1048575:0] memory_ram_d;
reg [1048575:0] memory_ram_q;

always @(posedge clk or
    negedge rst)
begin
    if (!rst)
    begin
        for (i=0;i<1048576; i=i+1)
            memory_ram_q[i] <= 0;
    end
    // else
    // begin
    //     for (i=0;i<1048576; i=i+1)
    //          memory_ram_q[i] <= memory_ram_d[i];
    // end
end


// always @(*)
// begin
//     for (i=0;i<1048576; i=i+1)
//         memory_ram_d[i] = memory_ram_q[i];
//     if  (write_rq && !read_rq && en)
//         memory_ram_d[rw_address] = write_data;
//     if  (!write_rq && read_rq && en)
//         read_data = memory_ram_q[rw_address];
//     else
//         read_data = 1'bz;

// end

endmodule

//...................................................
//...................................................
//...................................................
module mem_sys(
    clk,
    rst,
    read_rq_x,
    read_rq_w,
    write_rq_x,
    write_rq_w,
    rw_address_x,
    rw_address,
    write_data,
    read_data_x,
    read_data_w,
    sel_x,
    sel_w,
    vdd
);

input		vdd;
input[1:0]	sel_x;
input[1:0]      sel_w;
input           clk;
input           rst;
input           read_rq_x;
input           read_rq_w;
input           write_rq_x;
input           write_rq_w;
input[9:0]       rw_address_x;
input[19:0]      rw_address;
input	         write_data;
output     read_data_x;
output     read_data_w;

wire	sel_x_0;
wire    sel_x_1;
wire    sel_x_2;
wire    sel_x_3;

wire    sel_w_0;
wire    sel_w_1;
wire    sel_w_2;
wire    sel_w_3;


demux1to4 sel_for_x(
    .Data_in(vdd),
    .sel(sel_x),
    .Data_out_0(sel_x_0),
    .Data_out_1(sel_x_1),
    .Data_out_2(sel_x_2),
    .Data_out_3(sel_x_3)
);

demux1to4 sel_for_w(
    .Data_in(vdd),
    .sel(sel_w),
    .Data_out_0(sel_w_0),
    .Data_out_1(sel_w_1),
    .Data_out_2(sel_w_2),
    .Data_out_3(sel_w_3)
);


mem_small mem_for_x1(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address_x),
    .write_data(write_data),
    .read_rq(read_rq_x),
    .write_rq(write_rq_x),
    .read_data(read_data_x),
    .en(sel_x_0)  //...........enable

);

mem_small mem_for_x2(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address_x),
    .write_data(write_data),
    .read_rq(read_rq_x),
    .write_rq(write_rq_x),
    .read_data(read_data_x),
    .en(sel_x_1)  //...........enable

);
mem_small mem_for_x3(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address_x),
    .write_data(write_data),
    .read_rq(read_rq_x),
    .write_rq(write_rq_x),
    .read_data(read_data_x),
    .en(sel_x_2)  //...........enable

);
mem_small mem_for_x4(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address_x),
    .write_data(write_data),
    .read_rq(read_rq_x),
    .write_rq(write_rq_x),
    .read_data(read_data_x),
    .en(sel_x_3)  //...........enable

);







mem_large mem_for_w1(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w),
    .write_rq(write_rq_w),
    .read_data(read_data_w),
    .en(sel_w_0)  //...........enable
);

mem_large mem_for_w2(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w),
    .write_rq(write_rq_w),
    .read_data(read_data_w),
    .en(sel_w_1)  //...........enable

);

mem_large mem_for_w3(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w),
    .write_rq(write_rq_w),
    .read_data(read_data_w),
    .en(sel_w_2)  //...........enable

);

mem_large mem_for_w4(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w),
    .write_rq(write_rq_w),
    .read_data(read_data_w),
    .en(sel_w_3)  //...........enable

);

endmodule
