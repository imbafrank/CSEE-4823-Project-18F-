//~ `New testbench
`timescale  1ns / 1ps

module tb_mareg;

// reg Parameters
parameter PERIOD  = 10;
parameter mareg_input_width = 4;

// reg Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg [mareg_input_width/2-1:0]  	mareg_in_x = 0, mareg_in_w                       = 0 ;

// reg Outputs
wire [mareg_input_width/2-1:0]     mareg_out_op                            ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  1;
    #10 mareg_in_x=0; mareg_in_w=0;
    #10 mareg_in_x=0; mareg_in_w=1;
    #10 mareg_in_x=1; mareg_in_w=1;
    #10 mareg_in_x=1; mareg_in_w=0;

end


mareg #(
    .mareg_input_width ( mareg_input_width )) 
 u_mareg (
    .clk                     ( clk        ),
    .rst                     ( rst        ),
    .mareg_in_x              ( mareg_in_x   ),
    .mareg_in_w              ( mareg_in_w   ),
    .mareg_out_op            ( mareg_out_op    )
);

initial
begin
    $dumpfile("/home/netlab/nna/df.vcd");
    $dumpvars(0, tb_mareg);
     $display("\t\ttime,\tclk,\treset,\tx,\tw,\tout"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b",$time, clk,rst,mareg_in_x, mareg_in_w,mareg_out_op); 
    #100$finish;
end

endmodule
