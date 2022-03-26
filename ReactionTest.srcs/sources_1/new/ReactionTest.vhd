library IEEE;        
use IEEE.STD_LOGIC_1164.ALL;
-- Package mit unseren Konstanten hinzuf�gen                                 
use work.constants.all;

-- Deklaration der Entity
entity ReactionTest is
-- Deklaration von Ports
port(
    Clk    : in    std_logic;
    Start  : in    std_logic;
    Button : in    std_logic;
    Output : inout std_logic; 
    Green  : out   std_logic;
    Yellow : out   std_logic;
    Red    : out   std_logic);
end ReactionTest;
-- Zuweisung Architekture Rtl an Entity ReactionTest
architecture Rtl of ReactionTest is
-- Deklaration der Signale
signal Ticks    : integer := 0;    -- Z�hlt steigengde Flanken des Clocks
signal mSeconds : integer := 0; -- Z�hlt Millisekunden
signal Seconds  : integer := 0;  -- Z�hlt Sekunden
begin
    -- Der Prozess l�uft bei der �nderung des Clk-Events von neuem durch
	process(Clk) is
	variable PreviousSample   : integer;           -- f�r Delay-Messung
	variable CurrentSample    : integer;           -- f�r Delay-Messung
	variable MillisDifference : integer;           -- Delay zwichen Output-LED und gedr�ckte Taste
	variable StartFlag        : boolean := false;  --  "Start-Taste war gedr�ckt"-Flag
	begin
	    -- Wenn steigende Flanke entdeckt	
		if rising_edge(Clk) then
		    -- Wenn Start-Taste gedr�ckt ist (HIGH)
			if Start = '1' then
			    Ticks    <= 0;
				mSeconds <= 0;
                Seconds  <= 0;
                Output   <= '0';
                Green    <= '0';
                Yellow   <= '0';
                Red      <= '0';
                StartFlag := true;
            -- Wenn Start-Taste gedr�ckt war und t Sekunden sind vergangen                		
			elsif StartFlag and Seconds = t then
				Output <= '1';
				PreviousSample := mSeconds;
				StartFlag := false;
		    -- Wenn Output-LED leuchtet und Button-Taste ist gedruckt (HIGH).
			elsif Output = '1' and Button = '1' then
				CurrentSample := mSeconds;
				MillisDifference := CurrentSample - PreviousSample;
				-- Wenn Delay kleiner als tr1 ist
				if MillisDifference <= tr1 then
					Green <= '1';
				-- Wenn Delay zwischen tr1 und tr2 ist
				elsif MillisDifference > tr1 and MillisDifference <= tr2 then
					Yellow <= '1';
				-- Wenn Delay ist l�nger als tr2
				else
					Red <= '1';
				end if;
		    -- Wenn Start-Taste ausgelassen ist (LOW)	
			else
			     -- Wenn Ticks bis 1 ms gez�hlt hat.
			     if Ticks = (ClockFrequency/1000)-1 then
				    Ticks <= 0;
				        -- Wenn mSekond bis 1 s gez�hlt hat
					   if mSeconds = 1000 then
					       mSeconds <= 0;
						   Seconds <= Seconds+1;
					   -- Wenn nicht, dann mSeconds inkrementieren
					   else
					       mSeconds <= mSeconds+1;
					   end if;
					-- Wenn nicht, dann Ticks inkrementieren
					else
					   Ticks <= Ticks+1;
                    end if;
			end if;
		end if;		
	end process;
end Rtl;