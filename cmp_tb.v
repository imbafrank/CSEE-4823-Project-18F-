//~ `New testbench
`timescale  1ns / 1ps

module tb_cmp;

// cmp Parameters
parameter PERIOD  = 10;
parameter cmp_width = 4;

// cmp Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg  [cmp_width-1:0]   cmp_in_a                      = 0 ;

// cmp Outputs
wire [cmp_width-1:0]  cmp_out                             ;
wire [cmp_width-1:0]  cmp_b                           ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  1;
    #15 cmp_in_a=1;
    #25 cmp_in_a=3;
    #35 cmp_in_a=2;
end

initial
begin
    $dumpfile("/home/netlab/nna/df.vcd");
    $dumpvars(0, tb_cmp);
     $display("\t\ttime,\tclk,\treset,\tin,\tout"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b",$time, clk,rst,cmp_in_a,cmp_out, cmp_b); 
end

cmp  u_cmp (
    .clk                     ( clk        ),
    .rst                     ( rst        ),
    .cmp_in_a                ( cmp_in_a   ),

    .cmp_out                 ( cmp_out    ),
    .cmp_b                ( cmp_b   )

);

initial
begin

    #100$finish;
end

endmodule
