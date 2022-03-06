// Main Module for Traffic Light Controller, follows schematic from paper
module TLC_main(
    input clk,
    input reset,
    input sensor1,
    input sensor2,
    input peak,
    output [1:0] TL1,
    output [1:0] TL2,
    output [1:0] TL3,
    output [1:0] TL4,
    output [1:0] TL5,
    output [1:0] TL6); 

    reg peak;

    // Do peak off-peak inputs from separate file

    integer Timer;

    initial begin
        Timer <= 0;         // Set Timer to zero initially
    end

    // Reset conditions below , Initializes to TL1, TL6 green.
    always @(posedge clk)    
    if (reset == 0) begin
        Timer <= 0;
        TL1 <= 0;         TL2 <= 2;         TL3 <= 2;        TL4 <= 2;        TL5 <= 2;        TL6 <= 0;
    end

    // Increment timer with each positive clock cycle transition
    always @(posedge clk)
        Timer <= Timer + 1;

    // Control Traffic light output based on Timer values
    always @(*) begin
        // Peak condition cases
        if (peak) begin
            TL1 <= TL6; 
            TL2 <= TL4;
            TL3 <= TL5;
            case(TL1)
                0:if (Timer == 32) begin
                    Timer <= 0;
                    TL1 <= 1;
                end
                1:if (Timer == 4) begin
                    Timer <= 0;
                    TL1 <= 2;
                end 
                2:if (Timer == 4) && (TL2 == 2) && (TL3 == 2) begin
                    Timer <= 0;
                    TL2 <= 0;
                end 
            endcase
            case(TL2)
                0:if (Timer == 32) begin
                    Timer <= 0;
                    TL2 <= 1;
                end
                1:if (Timer == 4) begin
                    Timer <= 0;
                    TL2 <= 2;
                end 
                2:if (Timer == 4) && (TL1 == 2) && (TL3 == 2) begin
                    Timer <= 0;
                    TL3 <= 0;
                end 
            endcase
            case(TL3)
                0:if (Timer == 16) begin
                    Timer <= 0;
                    TL3 <= 1;
                end
                1:if (Timer == 4) begin
                    Timer <= 0;=
                    TL3 <= 2;
                end 
                2:if (Timer == 4) && (TL1 == 2) && (TL2 == 2) begin
                    Timer <= 0;
                    TL1 <= 0;
                end 
            endcase
        end
        // Off-Peak condition cases
        else begin
            // when both sensors are activated
            if (sensor1 && sensor2) begin
                TL1 <= TL6; 
                TL2 <= TL4;
                TL3 <= TL5;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL1 <= 2;
                    end 
                    2:if (Timer == 4) && (TL2 == 2) && (TL3 == 2) begin
                        Timer <= 0;
                        TL2 <= 0;
                    end 
                endcase
                case(TL2)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL2 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL2 <= 2;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) && (TL3 == 2) begin
                        Timer <= 0;
                        TL3 <= 0;
                    end 
                endcase
                case(TL3)
                    0:if (Timer == 8) begin
                        Timer <= 0;
                        TL3 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL3 <= 2;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) && (TL2 == 2) begin
                        Timer <= 0;
                        TL1 <= 0;
                    end 
                endcase
            end
            // when sensor1 is only activated
            else if (sensor1 = 1 && sensor2 = 0) begin 
                TL4 <= TL2;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                        TL6 <= TL1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL1 <= 2;
                        TL6 <= TL1;
                    end 
                    2:if (Timer == 4) && (TL2 == 2) && (TL3 == 2) begin
                        Timer <= 0;
                        TL2 <= 0;
                    end 
                endcase
                case(TL2)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL2 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL2 <= 2;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) && (TL3 == 2) begin
                        Timer <= 0;
                        TL3 <= 0;
                    end 
                endcase
                case(TL3)
                    0:if (Timer == 8) begin
                        Timer <= 0;
                        TL3 <= 1;
                        TL6 <= TL3;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL3 <= 2;
                        TL6 <= TL3;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) && (TL2 == 2) begin
                        Timer <= 0;
                        TL1 <= 0;
                        TL6 <= TL3;
                    end 
                endcase
            end
            // when sensor2 is only activated 
            else if (sensor1 = 0 && sensor1 = 1) begin 
                TL6 <= TL1;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL1 <= 2;
                    end 
                    2:if (Timer == 4) && (TL2 == 2) && (TL3 == 2) begin
                        Timer <= 0;
                        TL4 <= 0;
                    end 
                endcase
                case(TL4)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL4 = 1;
                        TL2 <= TL4;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL4 = 2;
                        TL2 <= TL4;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) && (TL5 == 2) begin
                        Timer <= 0;
                        TL5 <= 0;
                    end 
                endcase
                case(TL5)
                    0:if (Timer == 8) begin
                        Timer <= 0;
                        TL5 = 1;
                        TL2 <= TL5;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL5 <= 2;
                        TL2 <= TL5;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) && (TL4 == 2) begin
                        Timer <= 0;
                        TL5 <= 0;
                        TL2 <= TL5;
                    end 
                endcase
            end
            // when all sensors are deactivated
            else begin
                TL1 <= TL6; 
                TL2 <= TL4;
                case(TL1)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL1 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL1 <= 2;
                    end 
                    2:if (Timer == 4) && (TL2 == 2) && (TL3 == 2) begin
                        Timer <= 0;
                        TL2 <= 0;
                    end 
                endcase
                case(TL2)
                    0:if (Timer == 16) begin
                        Timer <= 0;
                        TL2 <= 1;
                    end
                    1:if (Timer == 4) begin
                        Timer <= 0;
                        TL2 <= 2;
                    end 
                    2:if (Timer == 4) && (TL1 == 2) begin
                        Timer <= 0;
                        TL1 <= 0;
                    end 
                endcase                
            end
        end            
    end

    





