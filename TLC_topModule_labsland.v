module TLC_topModule_labsland(
    input CLOCK_50,
    input [5:0] SW,                       // reset,ena,sensor1,sensor2,peakoffpeak
    output [17:0] LEDR,                   //each LED represnts one traffic light so 6*3=18
    output [2:0] LEDG,
    output [6:0] HEX0,                    
    output [6:0] HEX1,
    output [6:0] HEX2,
    output [6:0] HEX3,
    output [6:0] HEX4,
    output [6:0] HEX5,
    output [6:0] HEX6,
    output [6:0] HEX7
);

    wire reset,ena,sensor1,sensor2,peak1,reset1;
    wire [1:0] TL1,TL2,TL3,TL4,TL5,TL6;
    wire peak,pm,p,p1;
    wire [7:0] hh, mm, ss;
    wire [3:0] an;
    wire clk;
   
    localparam log2_slow_down_factor = 25;
    reg[24:0] counter = 0;
    assign clk = counter[24];
    always @(posedge CLOCK_50) counter = counter + 1;
    wire [7:0] timer;
    wire [11:0] timer_bcd;
    
  

    assign reset = ~SW[0];
    assign ena =   ~SW[1];
    assign sensor1 = SW[2];
    assign sensor2 = SW[3];
    assign peak = ~SW[4];
    assign peak1 = ~SW[5];
    assign an[0] = pm;
    

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

    assign LEDG[0] = an;
    assign LEDG[1] = (SW[4])? 0:1;
    assign LEDG[2] = (SW[5])? 0:1;

   


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
    .peak1(peak1)
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
    .peak(peak),
    .Timer(timer)
);

bin2bcd M1(
    .bin(timer),
    .bcd(timer_bcd)
);

sevenseg_driver timer1(
 .clk(clk), 
 .clr(1'b0), 
 .in1(hh[7:4]), 
 .in2(hh[3:0]), 
 .in3(mm[7:4]), 
 .in4(mm[3:0]),
 .in5(ss[7:4]),
 .in6(ss[3:0]),
 .seg1(HEX7), 
 .seg2(HEX6), 
 .seg3(HEX5), 
 .seg4(HEX4),
 .seg5(HEX3),
 .seg6(HEX2)
 );

sevenseg_driver1 timer2(
 .clk(clk), 
 .clr(1'b0), 
 .in5(timer_bcd[7:4]),
 .in6(timer_bcd[3:0]),
 .seg7(HEX1), 
 .seg8(HEX0)
 );




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

module sevenseg_driver(clk,clr,in1,in2,in3,in4,in5,in6,seg1,seg2, seg3, seg4,seg5,seg6);

  input clk;
  input clr;
  input [3:0] in1, in2, in3, in4, in5, in6;


  output [6:0] seg1;
  output [6:0] seg2;
  output [6:0] seg3;
  output [6:0] seg4;
  output [6:0] seg5;
  output [6:0] seg6;

 



  decoder_7seg disp1(in1,seg1);
  decoder_7seg disp2(in2,seg2);
  decoder_7seg disp3(in3,seg3);
  decoder_7seg disp4(in4,seg4);
  decoder_7seg disp5(in5,seg5);
  decoder_7seg disp6(in6,seg6);
 

endmodule

module sevenseg_driver1(clk,clr,in5,in6,seg7,seg8);
  input clk;
  input clr;
  input [3:0] in5, in6;
wire [7:0] timer;

  output [6:0] seg7;
  output [6:0] seg8;

  decoder_7seg disp7(in5,seg7);
  decoder_7seg disp8(in6,seg8);
  

  
  
endmodule


// Courtesy :: https://verilogcodes.blogspot.com/2015/10/verilog-code-for-8-bit-binary-to-bcd.html
module bin2bcd(
    bin,
     bcd
    );

    
    //input ports and their sizes
    input [7:0] bin;
    //output ports and, their size
    output [11:0] bcd;
    //Internal variables
    reg [11 : 0] bcd; 
     reg [3:0] i;   
     
     //Always block - implement the Double Dabble algorithm
     always @(bin)
        begin
            bcd = 0; //initialize bcd to zero.
            for (i = 0; i < 8; i = i+1) //run for 8 iterations
            begin
                bcd = {bcd[10:0],bin[7-i]}; //concatenation
                    
                //if a hex digit of 'bcd' is more than 4, add 3 to it.  
                if(i < 7 && bcd[3:0] > 4) 
                    bcd[3:0] = bcd[3:0] + 3;
                if(i < 7 && bcd[7:4] > 4)
                    bcd[7:4] = bcd[7:4] + 3;
                if(i < 7 && bcd[11:8] > 4)
                    bcd[11:8] = bcd[11:8] + 3;  
            end
        end     
                
endmodule

