module TLC_topModule_labsland(
    input CLOCK_50,
    input [3:0] SW; // reset,sensor1.sensor2,peakoffpeak
    output [17:0] LEDR; //each LED represnts one traffic light so 6*3=18
    output [6:0] HEX0;
    output [6:0] HEX1;
    output [6:0] HEX2;
    output [6:0] HEX3;
    output [3:0] LEDG;
);

    wire reset, ena,sensor1, sensor2;
    wire [1:0] TL1,TL2,TL3,TL4,TL5,TL6;
    wire peak, pm;
    wire [7:0] hh, mm, ss;
    wire [3:0] an;

    always @(CLOCK_50) counter = counter + 1;
    
    wire clk;
    assign clk = counter[23]; 

    assign reset = ~SW[0];
    assign ena =   ~SW[1];
    assign sensor1 = SW[2];
    assign sensor2 = SW[3];

    assign LEDR[0] = (TL1 == 0)? 1:0;
    assign LEDR[1] = (TL1 == 1)? 1:0;
    assign LEDR[2] = (TL1 == 2)? 1:0;
    assign LEDR[3] = (TL2 == 0)? 1:0;
    assign LEDR[4] = (TL2 == 1)? 1:0;
    assign LEDR[5] = (TL2 == 2)? 1:0;
    assign LEDR[6] = (TL3 == 0)? 1:0;
    assign LEDR[7] = (TL3 == 1)? 1:0;
    assign LEDR[8] = (TL3 == 2)? 1:0;
    assign LEDR[9] = (TL4 == 0)? 1:0;
    assign LEDR[10] = (TL4 == 1)? 1:0;
    assign LEDR[11] = (TL4 == 2)? 1:0;
    assign LEDR[12] = (TL5 == 0)? 1:0;
    assign LEDR[13] = (TL5 == 1)? 1:0;
    assign LEDR[14] = (TL5 == 2)? 1:0;
    assign LEDR[15] = (TL6 == 0)? 1:0;
    assign LEDR[16] = (TL6 == 1)? 1:0;
    assign LEDR[17] = (TL6 == 2)? 1:0;

    assign LEDG = an;

TwelveHourBCDclock BCD_clk(
    .clk(clk),
    .ena(ena),
    .reset(reset),
    .hh(hh),
    .mm(mm),
    .ss(ss),
    .pm(pm)
);

peak_offpeak BCD_peak(
    .hours(hh),
    .pm(pm),
    .peak(peak)
);

TLC_main Tlc_1(
    .clk(clk),
    .reset(reset),
    .sensor1(sensor1),
    .sensor2(sensor2),
    .TL1(TL1),
    .TL2(TL2),
    .TL3(TL3),
    .TL4(TL4),
    .TL5(TL5),
    .TL6(TL6),
    .peak(peak)
);

sevenseg_driver timer(
 .clk(clk), 
 .clr(1'b0), 
 .in1(mm[7:4]), 
 .in2(mm[3:0]), 
 .in3(ss[7:4]), 
 .in4(ss[3:0]), 
 .seg1(HEX3), 
 .seg2(HEX2), 
 .seg3(HEX1), 
 .seg4(HEX0), 
 .an(an));


endmodule


module decoder_7seg(in1,out1);

  input [3:0] in1;
  output reg [6:0] out1;

  always @ (in1)
    case (in1)
      4'b0000 : out1=7'b1000000; //0
      4'b0001 : out1=7'b1111001; //1
      4'b0010 : out1=7'b0100100; //2
      4'b0011 : out1=7'b0110000; //3
      4'b0100 : out1=7'b0011001; //4
      4'b0101 : out1=7'b0010010; //5
      4'b0110 : out1=7'b0000010; //6
      4'b0111 : out1=7'b1111000; //7
      4'b1000 : out1=7'b0000000; //8
      4'b1001 : out1=7'b0010000; //9
      4'b1010 : out1=7'b0001000; //A
      4'b1011 : out1=7'b0000011; //B
      4'b1100 : out1=7'b1000110; //C
      4'b1101 : out1=7'b0100001; //D
      4'b1110 : out1=7'b0000110; //E
      4'b1111 : out1=7'b0001110; //F
    endcase
      
endmodule

module sevenseg_driver(clk,clr,in1,in2,in3,in4,seg1,seg2, seg3, seg4, an);

  input clk;
  input clr;
  input [3:0] in1, in2, in3, in4;
//   output reg [6:0] seg = 7'b0;
  output [6:0] seg1;
  output [6:0] seg2;
  output [6:0] seg3;
  output [6:0] seg4;

  output reg [3:0] an = 4'b0;

//   wire [6:0] seg1, seg2, seg3, seg4;
  reg [12:0] segclk = 12'b0;

  localparam LEFT = 2'b00, MIDLEFT = 2'b01, MIDRIGHT = 2'b10, RIGHT = 2'b11;
  reg [1:0] state=LEFT;

  decoder_7seg disp1(in1,seg1);
  decoder_7seg disp2(in2,seg2);
  decoder_7seg disp3(in3,seg3);
  decoder_7seg disp4(in4,seg4);
    

endmodule














