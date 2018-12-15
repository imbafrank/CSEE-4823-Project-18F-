`timescale 1ns/1ps
`define MATLAB_OUT_FN "../test_input_1.results"

module memory_tb();

reg	clk;
reg	we_x;
reg	we_w;
reg	data_in;
reg[9:0]addr_x;
reg[19:0]addr_w;
reg[1:0]sel_x;
reg[1:0]sel_w;
wire	data_out_x;
wire	data_out_w;
integer matlab_out_file;



always begin
        #1 clk  = ~clk;
end

integer i;

initial begin
   clk = 0;
   @(posedge clk);
   @(posedge clk);
   $display("Hello!!!");
   matlab_out_file = $fopen(`MATLAB_OUT_FN,"r");
   if (!matlab_out_file)
   begin
      $display("Couldn't open the Matlab file.");
      $finish;
   end
   else begin
      $display("Matlab file opened");
   end 
	sel_x = 2;
        
	@(posedge clk);

	  for (i = 0; i<3; i = i+1) begin
	  $fscanf(matlab_out_file, "%d", data_in);
	  addr_x = i;
	we_x = 1;
	@(posedge clk);
          $display("Address is %b, I write %b",addr_x,data_in);
          end // for end  
        

        $display("BBBBBBB");  
        for (i = 0; i<3; i = i+1) begin
         we_x = 0; 
         addr_x = i;
	 @(posedge clk);
	  $display("Read %b at Address %b", data_out_x, addr_x);
          end // for end


 
//   $display("Read %b at Address %b", data_out_x, addr_x);
   $fclose(matlab_out_file);
   $finish;





end

mem_sys proto_mem (
     .clk(clk),
     .we_x(we_x),
     .we_w(we_w),
     .data_in(data_in),
     .data_out_x(data_out_x),
     .data_out_w(data_out_w),
     .address_x(addr_x),
     .address_w(addr_w),
     .sel_x(sel_x),
     .sel_w(sel_w)

);

endmodule
