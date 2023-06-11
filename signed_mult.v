`timescale 1ns / 1ps


module signed_mult(a , b , out);

    output [31:0] out;
    input signed [31:0] a;
    input signed [31:0] b;
    
    
    wire signed [63:0] mult_out;
    
    assign mult_out = a*b;
    
    assign out  = {mult_out[63] , mult_out[55:25]};
    
endmodule
