module mem_small(
    clk,
    rst,
    read_rq,
    write_rq,
    rw_address,
    write_data,
    read_data
);
input           clk;
input           rst;
input           read_rq;
input           write_rq;
input[16:0]      rw_address;
input[7:0]      write_data;
output[7:0]     read_data;

reg[7:0]     read_data;

integer out, i;
reg [7:0] memory_ram_d [127:0];
reg [7:0] memory_ram_q [127:0];

always @(posedge clk or
    negedge rst)
begin
    if (!rst)
    begin
        for (i=0;i<128; i=i+1)
            memory_ram_q[i] <= 0;
    end
    else
    begin
        for (i=0;i<128; i=i+1)
             memory_ram_q[i] <= memory_ram_d[i];
    end
end


always @(*)
begin
    for (i=0;i<128; i=i+1)
        memory_ram_d[i] = memory_ram_q[i];
    if (write_rq && !read_rq)
        memory_ram_d[rw_address] = write_data;
    if (!write_rq && read_rq)
        read_data = memory_ram_q[rw_address];
end

endmodule

//.................................................
module mem_medium(
    clk,
    rst,
    read_rq,
    write_rq,
    rw_address,
    write_data,
    read_data
);
input           clk;
input           rst;
input           read_rq;
input           write_rq;
input[16:0]      rw_address;
input[7:0]      write_data;
output[7:0]     read_data;

reg[7:0]     read_data;

integer out, i;
reg [7:0] memory_ram_d [1279:0];
reg [7:0] memory_ram_q [1279:0];

always @(posedge clk or
    negedge rst)
begin
    if (!rst)
    begin
        for (i=0;i<1279; i=i+1)
            memory_ram_q[i] <= 0;
    end
    else
    begin
        for (i=0;i<1279; i=i+1)
             memory_ram_q[i] <= memory_ram_d[i];
    end
end


always @(*)
begin
    for (i=0;i<1279; i=i+1)
        memory_ram_d[i] = memory_ram_q[i];
    if (write_rq && !read_rq)
        memory_ram_d[rw_address] = write_data;
    if (!write_rq && read_rq)
        read_data = memory_ram_q[rw_address];
end

endmodule

//...................................................
module mem_large(
    clk,
    rst,
    read_rq,
    write_rq,
    rw_address,
    write_data,
    read_data
);
input           clk;
input           rst;
input           read_rq;
input           write_rq;
input[16:0]      rw_address;
input[7:0]      write_data;
output[7:0]     read_data;

reg[7:0]     read_data;

integer out, i;
reg [7:0] memory_ram_d [131071:0];
reg [7:0] memory_ram_q [131071:0];

always @(posedge clk or
    negedge rst)
begin
    if (!rst)
    begin
        for (i=0;i<131072; i=i+1)
            memory_ram_q[i] <= 0;
    end
    else
    begin
        for (i=0;i<131072; i=i+1)
             memory_ram_q[i] <= memory_ram_d[i];
    end
end


always @(*)
begin
    for (i=0;i<131072; i=i+1)
        memory_ram_d[i] = memory_ram_q[i];
    if (write_rq && !read_rq)
        memory_ram_d[rw_address] = write_data;
    if (!write_rq && read_rq)
        read_data = memory_ram_q[rw_address];
end

endmodule

//...................................................
module mem_sys(
    clk,
    rst,
    read_rq_x,
    read_rq_w1,
    read_rq_w2,
    read_rq_w3,
    read_rq_w4,
    write_rq_x,
    write_rq_w1,
    write_rq_w2,
    write_rq_w3,
    write_rq_w4,
    rw_address,
    write_data,
    read_data_x,
    read_data_w1,
    read_data_w2,
    read_data_w3,
    read_data_w4,


);

input           clk;
input           rst;
input           read_rq_x;
input           write_rq_x;
input           read_rq_w1;
input           write_rq_w1;
input           read_rq_w2;
input           write_rq_w2;
input           read_rq_w3;
input           write_rq_w3;
input           read_rq_w4;
input           write_rq_w4;


input[16:0]      rw_address;
input[7:0]      write_data;
output[7:0]     read_data_x;
output[7:0]     read_data_w1;
output[7:0]     read_data_w2;
output[7:0]     read_data_w3;
output[7:0]     read_data_w4;


mem_small mem_for_x(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_x),
    .write_rq(write_rq_x),
    .read_data(read_data_x)
);

mem_large mem_for_w1(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w1),
    .write_rq(write_rq_w1),
    .read_data(read_data_w1)
);

mem_large mem_for_w2(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w2),
    .write_rq(write_rq_w2),
    .read_data(read_data_w2)
);

mem_large mem_for_w3(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w3),
    .write_rq(write_rq_w3),
    .read_data(read_data_w3)
);

mem_medium mem_for_w4(
    .clk(clk),
    .rst(rst),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_rq(read_rq_w4),
    .write_rq(write_rq_w4),
    .read_data(read_data_w4)
);

endmodule
