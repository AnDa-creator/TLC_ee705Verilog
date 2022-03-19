module TLC_topModule(
    input clk,
    input reset,
    input ena,
    input sensor1,
    input sensor2,
    output [1:0] TL1,
    output [1:0] TL2,
    output [1:0] TL3,
    output [1:0] TL4,
    output [1:0] TL5,
    output [1:0] TL6,
    output peak,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss
);

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

endmodule




















