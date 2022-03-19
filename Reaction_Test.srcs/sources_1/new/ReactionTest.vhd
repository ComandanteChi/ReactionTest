library IEEE; -- we need this library for std_logic          
use IEEE.STD_LOGIC_1164.ALL;                                 
use ieee.numeric_std.all;   --we need it for signed/unsigned 

entity ReactionTest is
generic (ClockFrequency : integer);
port(
    Clk    : in std_logic;
    Start  : in std_logic;
    Button : in std_logic;
    Output : inout std_logic; 
    Green : out std_logic;
    Yellow : out std_logic;
    Red : out std_logic);
end ReactionTest;
--Architecture "Rtl" of the entity "ReactionTest"
architecture Rtl of ReactionTest is
--Signal for counting clock periods
constant t : integer := 5;
constant tr1 : integer := 50;
constant tr2 : integer := 500;

signal mSeconds : integer := 0;
signal Seconds : integer := 0;
begin
	process(Clk) is
	variable PreviousSample : integer;
	variable CurrentSample : integer;
	variable MillisDifference : integer;
	variable StartFlag : boolean := false;
	begin	
		if rising_edge(Clk) then
			if Start = '1' then
				mSeconds <= 0;
                Seconds <= 0;
                Output <= '0';
                Green <= '0';
                Yellow <= '0';
                Red <= '0';
                StartFlag := true;               		
			elsif StartFlag and Seconds = t then
				Output <= '1';
				PreviousSample := mSeconds;
				StartFlag := false;
			elsif Output = '1' and Button = '1' then
				CurrentSample := mSeconds;
				MillisDifference := CurrentSample - PreviousSample;
				if MillisDifference <= tr1 then
					Green <= '1';
				elsif MillisDifference > tr1 and MillisDifference <= tr2 then
					Yellow <= '1';
				else
					Red <= '1';
				end if;	
			-- Is true every millisecond
			else
					-- Is true every millisecond
					if mSeconds = ClockFrequency-1 then
						mSeconds <= 0;
						Seconds <= Seconds+1;
					else
						mSeconds <= mSeconds+1;
					end if;

			end if;
		end if;
		
	end process;
end Rtl;