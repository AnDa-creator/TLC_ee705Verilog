// Main Module for Traffic Light Controller, follows schematic from paper
module TLC_main(
    input clk,
    input reset,
    input sensor1,
    input sensor2,
    input peak,
    output reg[1:0]  TL1,
    output reg[1:0]  TL2,
    output reg[1:0]  TL3,
    output reg[1:0]  TL4,
    output reg[1:0]  TL5,
    output reg[1:0]  TL6); 

    reg f16,f24,f35,f36,f25;

    // Do peak off-peak inputs from separate file
    
    
    integer Timer;

    initial begin
	 
        // Set Timer and flags to 0
        Timer <= 0;         
        Timer <= 0;
        TL1 <= 0;         TL2 <= 2;         TL3 <= 2;        TL4 <= 2;        TL5 <= 2;   
        TL6 <= 0;         f16 <= 0;         f24 <= 0;        f35 <= 0;  		f36 <= 0;
        f25 <= 0;  
    end	 
	 
	 // Reset conditions below , Initializes to TL1, TL6 green.
	 
    always @(posedge clk) 
        if (reset == 0) begin
            //initialize lights and flags
            Timer <= 0;
            TL1 <= 0;         TL2 <= 2;         TL3 <= 2;        TL4 <= 2;        TL5 <= 2;   
            TL6 <= 0;         f16 <= 0;         f24 <= 0;        f35 <= 0;  		f36 <= 0;
    		f25 <= 0;    
        end

    // Increment timer with each positive clock cycle transition
	always @(posedge clk)
        Timer <= Timer + 1;

		  
		  
    // Control Traffic light output based on Timer values
    always @(*) begin
	 
    // Peak condition cases
        if (peak) begin
            // Peak conditions
            case(TL1)
                0:if (Timer == 32) begin
                    Timer <= 0;
                    TL1 <= 1;
                end
                1:if ((Timer == 4) && (f16 == 0)) begin
                    Timer <= 0;
                    TL1 <= 2;
                    f16 <= 1; // set flag for next case execution
                end 
                2:if ((Timer == 4) && (f16 == 1)) begin
                    Timer <= 0;
                    TL2 <= 0;
                    f16 <= 0;  //reset flag and now tl goes high(2)
                end 
            endcase
            case(TL2)
                0:if (Timer == 32) begin
                    Timer <= 0;
                    TL2 <= 1;
                end
                1:if ((Timer == 4) && (f24 == 0)) begin
                    Timer <= 0;
                    TL2 <= 2;
                    f24 <= 1;
                end 
                2:if ((Timer == 4) && (f24 == 1)) begin
                    Timer <= 0;
                    TL3 <= 0;
                    f24 <= 0;
                end 
            endcase
            case(TL3)
                0:if (Timer == 16) begin
                    Timer <= 0;
                    TL3 <= 1;
                end
                1:if ((Timer == 4) && (f35 == 0)) begin
                    Timer <= 0;
                    TL3 <= 2;
                    f35 <= 1;
                end 
                2:if ((Timer == 4) && (f35 == 1)) begin
                    Timer <= 0;
                    TL1 <= 0;
                    f35 <= 0;
                end 
            endcase
            TL6 <= TL1; 
            TL4 <= TL2;
            TL5 <= TL3;
        end
    // Off-Peak condition cases
        
		else begin
		  
            // when both sensors are activated
            if ((sensor1 == 1) && (sensor2 == 1)) begin
                TL6 <= TL1; 
                TL4 <= TL2;
                TL5 <= TL3;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                    end
                    1:if ((Timer == 4) && (f16 == 0)) begin
                        Timer <= 0;
                        TL1 <= 2;
                        f16 <= 1;
                    end 
                    2:if ((Timer == 4) && (f16 == 1)) begin
                        Timer <= 0;
                        TL2 <= 0;
                        f16 <= 0;
                    end 
                endcase
                case(TL2)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL2 <= 1;
                    end
                    1:if ((Timer == 4) && (f24 == 0)) begin
                        Timer <= 0;
                        TL2 <= 2;
                        f24 <= 1;
                    end 
                    2:if ((Timer == 4) && (f24 == 1)) begin
                        Timer <= 0;
                        TL3 <= 0;
                        f24<= 0;
                    end 
                endcase
                case(TL3)
                    0:if (Timer == 8) begin
                        Timer <= 0;
                        TL3 <= 1;
                    end
                    1:if ((Timer == 4) && (f35 == 0)) begin
                        Timer <= 0;
                        TL3 <= 2;
                        f35 <= 1;
                    end 
                    2:if ((Timer == 4) && (f35 == 1)) begin
                        Timer <= 0;
                        TL1 <= 0;
                        f35 <= 0;
                    end 
                endcase
            end
        	// when only sensor1 is activated
			else if ((sensor1 == 1) && (sensor2 == 0))begin 
                TL4 <= TL2;
                TL6 <= (TL1 != 2) ? TL1 : TL3;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;                        
                    end
                    1:if ((Timer == 4) && (f16 == 0)) begin
                        Timer <= 0;
                        TL1 <= 2;
                        f16 <= 1;
                    end 
                    2:if ((Timer == 4) && (f16 == 1)) begin
                        Timer <= 0;
                        TL2 <= 0;
                        f16 <= 0;
                    end 
                endcase
                case(TL2)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL2 <= 1;
                    end
                    1:if ((Timer == 4) && (f24 == 0)) begin
                        Timer <= 0;
                        TL2 <= 2;
                        f24 <= 1;
                    end 
                    2:if ((Timer == 4) && (f24 == 1)) begin
                        Timer <= 0;
                        TL3 <= 0;
                        f24 <= 0;
                    end 
                endcase
                case(TL3)
                    0:if (Timer == 8) begin
                        Timer <= 0;
                        TL3 <= 1;
                    end
                    1:if ((Timer == 4) && (f36 == 0)) begin
                        Timer <= 0;
                        TL3 <= 2;
						f36 <= 1;
                    end 
                    2:if ((Timer == 4) && (f36 == 1)) begin
                        Timer <= 0;
                        TL1 <= 0;
						f36 <= 0;
                    end 
                endcase
            end
            // when sensor2 is only activated 
            else if ((sensor1 == 0) && (sensor1 == 1)) begin 
                TL6 <= TL1;
                TL2 <= (TL4 != 2) ? TL4 : TL5;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                    end
                    1:if ((Timer == 4) && (f16 == 0))begin
                        Timer <= 0;
                        TL1 <= 2;
						f16 <= 1;
                    end 
                    2:if ((Timer == 4) && (f16 == 1)) begin
                        Timer <= 0;
                        TL4 <= 0;
						f16 <= 0;
                    end 
                endcase
                case(TL4)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL4 = 1;
                    end
                    1:if ((Timer == 4) && (f24 == 0)) begin
                        Timer <= 0;
                        TL4 = 2;
						f24 <= 1;
                    end 
                    2:if ((Timer == 4) && (f24 == 1)) begin
                        Timer <= 0;
                        TL5 <= 0;
						f24 <= 0;
                    end 
                endcase
                case(TL5)
                    0:if (Timer == 8) begin
                        Timer <= 0;
                        TL5 = 1;
                    end
                    1:if ((Timer == 4) && (f25 == 0)) begin
                        Timer <= 0;
                        TL5 <= 2;
						f25 <= 1;
                    end 
                    2:if ((Timer == 4) && (f25 == 1)) begin
                        Timer <= 0;
                        TL1 <= 0;
						f25 <=0;
                    end 
                endcase
            end
            // when all sensors are deactivated
            else begin
                TL6 <= TL1; 
                TL4 <= TL2;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                    end
                    1:if ((Timer == 4) && (f16 == 0)) begin
                        Timer <= 0;
                        TL1 <= 2;
						f16 <= 1;
                    end 
                    2:if ((Timer == 4) && (f16 == 1)) begin
                        Timer <= 0;
                        TL2 <= 0;
						f16 <= 0;
                    end 
                endcase
                case(TL2)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL2 <= 1;
                    end
                    1:if ((Timer == 4) && (f24 == 0)) begin
                        Timer <= 0;
                        TL2 <= 2;
						f24 <= 1;
                    end 
                    2:if ((Timer == 4) && (f24 == 1)) begin
                        Timer <= 0;
                        TL1 <= 0;
						f24 <= 0;
                    end 
                endcase                
            end
        end            
    end
endmodule