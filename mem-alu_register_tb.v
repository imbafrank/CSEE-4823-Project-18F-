//~ `New testbench
`timescale  1ns / 1ps

module tb_nn;

// nn Parameters
parameter PERIOD  = 10;


// nn Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;

// nn Outputs



initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

nn  u_nn (
    .clk                     ( clk   ),
    .rst                     ( rst   )
);

initial
begin

    $finish;
end

endmodule
