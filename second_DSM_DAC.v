`timescale 1ns / 1ps


module second_DSM_DAC#(

    parameter dac_bw = 16,
    parameter osr    = 6
)
(
    input clk,
    input wire [15:0] din,
    output wire dout
    
);

    localparam  mid_val = (1 << (dac_bw - 1)) + (1 << (osr + 2));
    
    localparam  bw_extra = 2;
    localparam  bw_total = dac_bw + bw_extra;
    
    reg  dout_r = 1'b0;
    reg  dac_dout = 1'b0;
    
    reg signed [bw_total - 1 : 0] DAC_ACC1 = 0;
    wire signed [bw_total - 1 : 0] max_val = mid_val;
    wire signed [bw_total - 1 : 0] min_val = -mid_val;
    wire signed [bw_total - 1 : 0] dac_val = (!dout_r) ? max_val : min_val;
    
    
    wire signed [bw_total - 1 : 0] in_ext = {{bw_extra{din[dac_bw - 1]}} , din};
    wire signed [bw_total - 1 : 0] delta_s0_c0 = in_ext + dac_val;
    wire signed [bw_total - 1 : 0] delta_s0_c1 = DAC_ACC1 + delta_s0_c0;
    
    
    /*assign dac_val = (!dout_r) ? max_val : min_val;
    assign in_ext  = {{bw_extra{din[dac_bw - 1]}} , din};
    assign delta_s0_c0 = in_ext + dac_val;
    assign delta_s0_c1 = DAC_ACC1 + delta_s0_c0;*/
    
    always@(posedge clk)
    begin
    
        DAC_ACC1 <= delta_s0_c1;
    
    end
    
    localparam  bw_total2 = bw_total + osr;
    
    reg signed  [bw_total2 - 1 : 0] DAC_ACC2 = 0;
    wire signed [bw_total2 - 1 : 0] max_val2 = mid_val;
    wire signed [bw_total2 - 1 : 0] min_val2 = -mid_val;
    wire signed [bw_total2 - 1 : 0] dac_val2 = (!dout_r) ? max_val2 : min_val2;
    
    
    wire signed [bw_total2 - 1 : 0] in_ext2 = {{osr{delta_s0_c1[bw_total - 1]}} , delta_s0_c1};
    wire signed [bw_total2 - 1 : 0] delta_s1_c0 = in_ext2 + dac_val2;
    wire signed [bw_total2 - 1 : 0] delta_s1_c1 = DAC_ACC2 + delta_s1_c0;
    
    /*assign dac_val2 = (!dout_r) ? max_val2 : min_val2;
    assign in_ext2  = {{osr{din[bw_total - 1]}} , delta_s1_c1};
    assign delta_s1_c0 = in_ext2 + dac_val2;
    assign delta_s1_c1 = DAC_ACC2 + delta_s1_c0;*/
    
    
    always@(posedge clk)
    begin
    
        DAC_ACC2 <= delta_s1_c1;
    
    end
    
    always@(posedge clk)
    begin
    
        dout_r   <= delta_s1_c1[bw_total2 - 1];
        dac_dout <= ~dout_r;
    
    end
    
    
    assign dout = dout_r;
    
endmodule
