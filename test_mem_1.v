`define MATLAB_OUT_FN "../test_input_1.results"

module memory_tb();
reg 		clk, rst;
reg[19:0]	rw_address;
reg[9:0]	rw_address_x;
reg	        write_data;
reg[1:0]	sel_x;
reg[1:0]	sel_w;
reg		read_rq_x;
reg		write_rq_x;
reg             read_rq_w;
reg             write_rq_w;
reg		vdd;
wire	   read_data_x;
wire       read_data_w;
reg[9:0]		q_cnt;
integer matlab_out_file;

// Start the CLK
initial begin
   vdd =1'b1;
   $display("Hello!!!");
   clk = 0;
   forever #10 clk = ~clk;
   //$display("Hello!!!");
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
            sel_w = 1; 
            read_rq_w = 0;
            write_rq_w = 1;
	    q_cnt = q_cnt+1; 
            $fscanf(matlab_out_file, "%d", write_data);
	    sel_x = 1;
            read_rq_x = 0;
            write_rq_x = 1;
	    rw_address_x = q_cnt;
	    $display("Address is %b, I write %b",rw_address_x,write_data);
          end
	  else
	  begin
            sel_x = 2;
	    rw_address_x = 5;
            read_rq_x = 1;
            write_rq_x = 0;
            #50  $display("Read %b at Address %b", read_data_x, rw_address_x);
            $fclose(matlab_out_file);
	    $finish;

          end

	end

end

mem_sys proto_mem (
    .vdd(vdd),
    .clk(clk),
    .rst(rst),
    .read_rq_x(read_rq_x),
    .read_rq_w(read_rq_w),
    .sel_x(sel_x),
    .sel_w(sel_w),
    .write_rq_x(write_rq_x),
    .write_rq_w(write_rq_w),
    .rw_address(rw_address),
    .rw_address_x(rw_address_x),

    .write_data(write_data),

    .read_data_x(read_data_x),
    .read_data_w(read_data_w)
);

endmodule
