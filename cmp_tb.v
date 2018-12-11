//test
`timescale  1ns / 1ps

module tb_cmp;

// cmp Parameters
parameter PERIOD  = 10;


// cmp Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   cmp_in_a                             = 0 ;

// cmp Outputs
wire  cmp_out                              ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

cmp  u_cmp (
    .clk                     ( clk        ),
    .rst                     ( rst        ),
    .cmp_in_a                ( cmp_in_a   ),

    .cmp_out                 ( cmp_out    )
);

initial
begin

    $finish;
end

endmodule
