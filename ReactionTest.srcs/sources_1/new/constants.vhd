library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Package Initialisation
package constants is
constant t              : integer    := 5;
constant tr1            : integer    := 50;
constant tr2            : integer    := 500;
constant ClockFrequency : integer    := 1000;  -- Frequenz muss nicht kleiner
                                               -- als 1 kHz sein!
constant ClockPeriod    : time       := 1000 ms / ClockFrequency; 
end constants;