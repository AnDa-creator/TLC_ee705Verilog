# TLC_ee705Verilog

\section{Introduction and Objectives}
Traffic signals generally operate with a fixed time for red and green lights. To manage traffic better, the fixed time value can be controlled and changed according to traffic conditions. The aim of the project is to implement a Traffic Light Controller (TLC) which will operate according to the traffic load. It is simulated in quartus and also tested on FPGA at \href{https://iitb.labsland.com/standalone/login}{Labsland}. The objectives for the project can be broadly as follows :
\begin{itemize}
    \item Implement a design of a modern FPGA-based Traffic Light Control (TLC) System to manage the road traffic.
    \item Intelligent peak timing method based on sensors, more efficient than usual fixed time method.
    \item Hierarchical (Module based) design of the system in verilog and conversion for running in FPGA.
\end{itemize}

\section{Implementation - Components used}
The code is implemented in the form of four modules:
\begin{itemize}
    \item Clock module -- A twelve hour BCD clock with am and pm indicator.
    \item TLC main module -- The state macheine of fig. \ref{fig:state_flow} is implemented here.
    \item Peak -  Off-peak module -- Determines the timings of the day to be considered as peak traffic time or not.
    \item Top module to integrate all the submodules.
\end{itemize}

The input signals to the overall design is as follows :
\begin{itemize}
    \item \textit{clk} -- System clock, set according to time granularity required.
    \item \textit{sensor1} and \textit{sensor2} -- Sensor values need to be fed externally through hardware interfacing.
    \item \textit{ena} -- Enable for clock.
    \item \textit{reset} -- Restart the entire system while set.
\end{itemize}
The output signals are :
\begin{itemize}
    \item \textit{TL1 to TL6} -- Traffic light outputs, each two bit values with encoding as mentioned earlier.
\end{itemize}
