`timescale 1ns / 1ns


module TLC_tb;

    reg clk; reg reset;                                 // clk and reset
    reg ena; reg sensor1; reg sensor2;                  // enable and sensors

    wire [1:0] TL1; wire [1:0] TL2;                     // TL1 and TL2
    wire [1:0] TL3; wire [1:0] TL4;                     // TL3 and TL4
    wire [1:0] TL5; wire [1:0] TL6;                     // TL5 and TL6
    wire peak; wire pm;                                 // peak and pm
    wire [7:0] hh; wire [7:0] mm; wire [7:0] ss;        // hh, mm, ss

TLC_topModule dut0 (
    .clk(clk), .reset(reset), .ena(ena), .sensor1(sensor1), .sensor2(sensor2),
    .TL1(TL1), .TL2(TL2), .TL3(TL3), .TL4(TL4), .TL5(TL5), .TL6(TL6),
    .peak(peak), .pm(pm), .hh(hh), .mm(mm), .ss(ss)
);

always begin
    #1 clk = ~clk ;
    #1000 sensor1 = ~sensor1;
    #500 sensor2 = ~sensor2;
end

 initial begin
   $dumpvars();

    clk = 0; reset = 0; ena = 1; sensor1 = 0; sensor2 = 0;

    #10 reset = 1; 

    #86400 $finish;
 end

endmodule








































