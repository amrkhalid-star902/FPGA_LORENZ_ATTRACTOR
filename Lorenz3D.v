`timescale 1ns / 1ps


module Lorenz3D(
    clk,
    pinX,
    pinY,
    pinZ,
    );
	 
	 
   input wire clk;
   output wire pinX;
   output wire pinY;
   output wire pinZ;

   
	 
	 

	 wire signed [31:0] x , y , z , xm , ym , zm;
	 wire signed [31:0] scale1 = {7'b0000011 , 25'b11100001000000000000};
	 wire signed [7:0] xs , ys , zs;
	 
	reg [31:0] key; 
	 
	 
	 
	 wire slowclock;

	 
	 Slowclock clock ( .clk(clk), .slowclock(slowclock));
	 

	 
	 
     Lorenz  L1(
     .clk(slowclock),
     .x(x),
     .y(y),
     .z(z)
    );
	 


	 
	 
	//delta_sigma_dac d1 (.clk(clk), .PWM_in(x[31:9]), .PWM_out(pinY));
    //delta_sigma_dac d2 (.clk(clk), .PWM_in(y[31:9]), .PWM_out(pinY));
	//delta_sigma_dac d3 (.clk(clk), .PWM_in(z[31:9]), .PWM_out(pinZ));
	
	second_DSM_DAC #(16 , 6) DSA11 (.clk(clk) , .din(x[31:16]) , .dout(pinX));
	second_DSM_DAC #(16 , 6) DSA12 (.clk(clk) , .din(y[31:16]) , .dout(pinY));
	second_DSM_DAC #(16 , 6) DSA13 (.clk(clk) , .din(z[31:16]) , .dout(pinZ));
	
	
	
	signed_mult sm1 (.a(x) , .b(scale1) , .out(xm));
	signed_mult sm2 (.a(y) , .b(scale1) , .out(ym));
	signed_mult sm3 (.a(z) , .b(scale1) , .out(zm));
	
	 


    
endmodule
