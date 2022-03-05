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

    // Do peak off-peak inputs
    integer Timer;

    initial begin
        Timer <= 0;
    end

    always @(posedge clk)    
    if (reset == 0) begin
        Timer <= 0;
        TL1 <= 0;         TL2 <= 2;         TL3 <= 2;        TL4 <= 2;        TL5 <= 2;        TL6 <= 0;
    end

    always @(posedge clk)
        Timer <= Timer + 1;

    always @(*) begin
        if (peak) begin
            case(TL1)
                0:if (Timer = 32) begin
                    Timer <= 0;
                    TL1 <= 1;
                end
                1:if (Timer = 4) begin
                    Timer <= 0;
                    TL1 <= 2;
                end 
                2:if (Timer = 4) && (TL2 = 2) && (TL3 = 2) begin
                    Timer <= 0;
                    TL2 <= 0;
                end 
            endcase
            case(TL2)
                0:if (Timer = 32) begin
                    Timer <= 0;
                    TL2 <= 1;
                end
                1:if (Timer = 4) begin
                    Timer <= 0;
                    TL2 <= 2;
                end 
                2:if (Timer = 4) && (TL1 = 2) && (TL3 = 2) begin
                    Timer <= 0;
                    TL3 <= 0;
                end 
            endcase
            case(TL3)
                0:if (Timer = 16) begin
                    Timer <= 0;
                    TL3 <= 1;
                end
                1:if (Timer = 4) begin
                    Timer <= 0;
                    TL3 <= 2;
                end 
                2:if (Timer = 4) && (TL1 = 2) && (TL2 = 2) begin
                    Timer <= 0;
                    TL1 <= 0;
                end 
            endcase
        end

        else begin
            case(TL1)
                0:if (Timer = 16) begin
                    Timer <= 0;
                    TL1 <= 1;
                end
                1:if (Timer = 4) begin
                    Timer <= 0;
                    TL1 <= 2;
                end 
                2:if (Timer = 4) && (TL2 = 2) && (TL3 = 2) begin
                    Timer <= 0;
                    TL2 <= 0;
                end 
            endcase
            case(TL2)
                0:if (Timer = 16) begin
                    Timer <= 0;
                    TL2 <= 1;
                end
                1:if (Timer = 4) begin
                    Timer <= 0;
                    TL2 <= 2;
                end 
                2:if (Timer = 4) && (TL1 = 2) && (TL3 = 2) begin
                    Timer <= 0;
                    TL3 <= 0;
                end 
            endcase
            case(TL3)
                0:if (Timer = 8) begin
                    Timer <= 0;
                    TL3 <= 1;
                end
                1:if (Timer = 4) begin
                    Timer <= 0;
                    TL3 <= 2;
                end 
                2:if (Timer = 4) && (TL1 = 2) && (TL2 = 2) begin
                    Timer <= 0;
                    TL1 <= 0;
                end 
            endcase
        end            
    end

    assign TL1 = TL6;
    assign TL2 = TL4;
    assign TL3 = TL5;





