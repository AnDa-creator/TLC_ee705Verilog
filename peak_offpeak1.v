// The following code is slightly changed(from peak_offpeak.v) for LabsLand implementation(only variable name is changed to peak1 instead of peak)------

module peak_offpeak(
    input [7:0] hours,
    input pm,
    output reg peak1);

// Peak Hour Periods -- 0700 – 0900, 1200 – 1400 and 1700 – 1900 hours
// Edit on Parth's PC
initial 
    peak1 = 0;

always @(*) begin
    if (~pm) begin
        if  ((hours[3:0] <= 9) && (hours[3:0] >= 7)) 
            peak1 <= 1;
        
        else 
            peak1 <= 0;
    end
    else begin
        if  (((hours[3:0] <= 2) && (hours[3:0] >= 0)) || ((hours[3:0] <= 7) && (hours[3:0] >= 5))) 
            peak1 <= 1;  
        else 
            peak1 <= 0;    
        end
    end

endmodule
