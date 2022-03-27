module TwelveHourBCDclock(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss); 
    
    // Starting from 1 am
    initial begin
        hh = 8'b00000011;
        ss = 8'b00000000;
        mm = 8'b00000000;
        pm = 1'b1;
    end
        
    
    // Logic changes at positive edge of clock, reset synchronous active low
    always @(posedge clk) begin

        // Count of register for Seconds increases at ena == 1, BCD encoding is done
        if (ena) begin 
            if (ss[3:0] < 9) 
                ss[3:0] <= ss[3:0] + 1;
            else begin
                ss[3:0] <= 0; 
                ss[7:4] <= ss[7:4] + 1;
            end

        // Increase in minute count and seconds rollover
        if(ss[7:4] == 5 && ss[3:0] == 9) begin 
            ss <= 0;
            if (mm[3:0] < 9) 
                mm[3:0] <= mm[3:0] + 1;
            else begin
                mm[3:0] <= 0; 
                mm[7:4] <= mm[7:4] + 1;
            end
        end

        // Increase in hours count and minutes rollover
        if(ss[7:4] == 5 && ss[3:0] == 9 && mm[7:4] == 5 && mm[3:0] == 9) begin 
            mm <= 0;
            if (hh[3:0] < 9) 
                hh[3:0] <= hh[3:0] + 1;
            else begin
                hh[3:0] <= 0; 
                hh[7:4] <= hh[7:4] + 1;
            end
        end

        // Rollover in hours from 12 pm/am to 1 am/pm
        if(ss[7:4] == 5 && ss[3:0] == 9 && mm[7:4] == 5 && mm[3:0] == 9 && hh[7:4] == 1 && hh[3:0] == 2) begin 
            hh <= 1;
        end

        // Complement pm at 11:59:59 am/pm to 12:00:00 pm/am
        if(ss[7:4] == 5 && ss[3:0] == 9 && mm[7:4] == 5 && mm[3:0] == 9 && hh[7:4] == 1 && hh[3:0] == 1) begin 
            pm <= ~pm;
        end

        end

        // Logic to reset the clock
        if(~reset) begin
            ss <= 0;
            hh[7:4] <= 0;
            hh[3:0] <= 3;
            
            //hh[7:4] <= 0;
            //hh[3:0] <= 1;
            pm <= 1;
            mm <= 0;
        end
    end
    
    

endmodule
