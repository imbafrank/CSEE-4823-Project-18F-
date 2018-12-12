`define MATLAB_OUT_FN "../test_input_1.results"

module memory_tb();
reg 		clk, rst;
reg[16:0]	rw_address;
reg[7:0]	write_data;
reg		read_rq_x;
reg		write_rq_x;
reg             read_rq_w1;
reg             write_rq_w1;
reg             read_rq_w2;
reg             write_rq_w2;
reg             read_rq_w3;
reg             write_rq_w3;
reg             read_rq_w4;
reg             write_rq_w4;
wire[7:0]	read_data_x;
wire[7:0]       read_data_w1;
wire[7:0]       read_data_w2;
wire[7:0]       read_data_w3;
wire[7:0]       read_data_w4;
reg[16:0]		q_cnt;
integer matlab_out_file;

// Start the CLK
initial begin
    clk = 0;
   forever #10 clk = ~clk;
   $display("Hello!!!");
end

//Reset signal and open matlab file
initial begin
        rst = 0;
        # 50 rst = 1;
       matlab_out_file = $fopen(`MATLAB_OUT_FN,"r");
       if (!matlab_out_file)
       begin
          $display("Couldn't open the Matlab file.");
          $finish;
       end
       else begin
          $display("Matlab file opened");
       end
end

always @(posedge clk or negedge rst)
begin
	if (!rst)
	begin
	  q_cnt = 0;
	  write_data = 0;
	end

	else
	begin
	  if (q_cnt < 8)
          begin
	    q_cnt = q_cnt+1; 
            $fscanf(matlab_out_file, "%d", write_data);
            read_rq_w2 = 0;
            write_rq_w2 = 1;
	    rw_address = q_cnt;
	    $display("Address is %b, I write %b",rw_address,write_data);
          end
	  else
	  begin
	    rw_address = 5;
            read_rq_w2 = 1;
            write_rq_w2 = 0;
            # 50 $display("Read %b at Address %b", read_data_w2, rw_address);
            $fclose(matlab_out_file);
	    $finish;

          end

	end

end

mem_sys proto_mem (
    .clk(clk),
    .rst(rst),
    .read_rq_x(read_rq_x),
    .read_rq_w1(read_rq_w1),
    .read_rq_w2(read_rq_w2),
    .read_rq_w3(read_rq_w3),
    .read_rq_w4(read_rq_w4),
    .write_rq_x(write_rq_x),
    .write_rq_w1(write_rq_w1),
    .write_rq_w2(write_rq_w2),
    .write_rq_w3(write_rq_w3),
    .write_rq_w4(write_rq_w4),
    .rw_address(rw_address),
    .write_data(write_data),
    .read_data_x(read_data_x),
    .read_data_w1(read_data_w1),
    .read_data_w2(read_data_w2),
    .read_data_w3(read_data_w3),
    .read_data_w4(read_data_w4)
);

endmodule
