`timescale 1ns / 1ps



module Slowclock(
    input clk,
    output slowclock
    );
    
    reg [25:0] counter = 0;
    reg clockout = 0;
    
    always@(posedge clk)
    begin
    
        if( counter == 1)
        begin
            
            clockout <= !clockout;        
            counter <= 0;
            
        end
        else
            counter <= counter + 1;
    
    end
    
    assign slowclock = clockout;
    
endmodule
