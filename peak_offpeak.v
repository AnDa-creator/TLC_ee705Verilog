module peak_offpeak(
    input [7:0] hours,
    input pm,
    output reg peak);

// Peak Hour Periods -- 0700 – 0900, 1200 – 1400 and 1700 – 1900 hours

initial 
    peak = 0;

always @(*) begin
    if (~pm) begin
        if  ((hours[3:0] <= 9) && (hours[3:0] >= 7)) 
            peak <= 1;
        
        else 
            peak <= 0;
    end
    else begin
        if  (((hours[3:0] <= 2) && (hours[3:0] >= 0)) || ((hours[3:0] <= 7) && (hours[3:0] >= 5))) 
            peak <= 1;  
        else 
            peak <= 0;    
        end
    end

endmodule



