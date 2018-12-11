//~ `New testbench
`timescale  1ns / 1ps

module tb_agg;

// agg Parameters
parameter PERIOD = 10;
parameter agg_width  = 12;

// agg Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   [agg_width-1:0]  agg_in                      = 0 ;

// agg Outputs
//wire  [agg_width-1:0]  agg_out                     ;
wire  [agg_width-1:0] agg_out2alu                         ;
wire  agg_out2act                          ;
wire  agg_out_acted                        ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  1;
    #15 agg_in=1;
    #15 agg_in=3;
    #15 agg_in=2;
    #10 agg_in=1024;
    #10 agg_in=2048;

end

agg #(
    .agg_width ( agg_width ))
 u_agg (
    .clk                     ( clk                    ),
    .rst                     ( rst                    ),
    .agg_in                  ( agg_in         [agg_width-1:0] ),

    .agg_out2alu                 ( agg_out2alu        [agg_width-1:0] ),
    .agg_out2act             ( agg_out2act            ),
    .agg_out_acted           ( agg_out_acted          )
);

initial
begin
$dumpfile("/home/netlab/nna/df.vcd");
    $dumpvars(0, tb_agg);
     $display("\t\ttime,\tclk,\treset,\tin,\tout2act,\toutacted,\tout2alu"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t%b",$time, clk,rst,agg_in,agg_out2act, agg_out_acted, agg_out2alu); 
    #100$finish;
end

endmodule
