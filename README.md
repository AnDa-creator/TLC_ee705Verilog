# TLC_ee705Verilog

##Introduction and Objectives
Traffic signals generally operate with a fixed time for red and green lights. To manage traffic better, the fixed time value can be controlled and changed according to traffic conditions. The aim of the project is to implement a Traffic Light Controller (TLC) which will operate according to the traffic load. It is simulated in quartus and also tested on FPGA at \href{https://iitb.labsland.com/standalone/login}{Labsland}. The objectives for the project can be broadly as follows :

* Implement a design of a modern FPGA-based Traffic Light Control (TLC) System to manage the road traffic.
* Intelligent peak timing method based on sensors, more efficient than usual fixed time method.
* Hierarchical (Module based) design of the system in verilog and conversion for running in FPGA.


##Implementation - Components used
The code is implemented in the form of four modules:
* Clock module -- A twelve hour BCD clock with am and pm indicator.
* TLC main module -- The state macheine of fig. \ref{fig:state_flow} is implemented here.
* Peak -  Off-peak module -- Determines the timings of the day to be considered as peak traffic time or not.
* Top module to integrate all the submodules.
\end{itemize}

The input signals to the overall design is as follows :
* \textit{clk} -- System clock, set according to time granularity required.
* \textit{sensor1} and \textit{sensor2} -- Sensor values need to be fed externally through hardware interfacing.
* \textit{ena} -- Enable for clock.
* \textit{reset} -- Restart the entire system while set.
The output signals are :
* \textit{TL1 to TL6} -- Traffic light outputs, each two bit values with encoding as mentioned earlier.
