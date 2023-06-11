`timescale 1ns / 1ps


module Lorenz(clk , x , y , z);


    
    wire signed [31:0] sigma = {7'b0001010 , 25'b0}; //10
    wire signed [31:0] beta = {7'b0000010 , 25'b1010101010101010101010101}; //8/3
    wire signed [31:0] rho = {7'b0011100 , 25'b0}; //28
    //wire signed [31:0] scale = {7'b0000001 , 20'b10000000001010101010};
    wire signed [31:0] dt = {7'b0 , 20'b00000001000000000000};
    parameter signed [31:0] xo = {7'b1000001 , 25'b0}; //-1
    parameter signed [31:0] yo = {7'b0 , 25'b0001100110011001100110011}; //0.1
    parameter signed [31:0] zo = {7'b0011001 , 25'b0}; //25
    
    
    input wire clk;
    output reg signed [31:0] x = xo ;
    output reg signed [31:0] y = yo;
    output reg signed [31:0] z = zo;

    reg signed [26:0] dx;
    reg signed [26:0] dy;
    reg signed [26:0] dz;
    
    wire signed [31:0] m1 , m2 , m3 , m4 , m5 , m6 , m7 , m8 , m9;
    wire signed [31:0] xn , yn , zn;
    wire signed [31:0] scale = {7'b0000010 , 25'b0};
    
    signed_mult sm1 (.a(m1) , .b(sigma) , .out(m2));
    signed_mult sm2 (.a(m3) , .b(m4) , .out(m5));
    signed_mult sm3 (.a(m3) , .b(y) , .out(m6));
    signed_mult sm4 (.a(m7) , .b(beta) , .out(m8));
    
    assign m1 = (y - x) >>> 8;
    assign m3 = x >>> 8;
    assign m4 = rho - z;
    assign m7 = z >>> 8;
    assign m9 = (y >>> 8);
    
    always@(posedge clk)
    begin
    
        x = x + m2;
        y = y + m5 - m9;
        z = z + m6 - m8;
        
        
            
    end
    signed_mult sm5 (.a(x) , .b(scale) , .out(xn));
    signed_mult sm6 (.a(y) , .b(scale) , .out(yn));
    signed_mult sm7 (.a(z) , .b(scale) , .out(zn));
    
    
endmodule
