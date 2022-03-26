library IEEE;        
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;
 
entity ReactionTestTb is
end entity;

-- Zuweisung Architekture Sim an Entity ReactionTestTb 
architecture Sim of ReactionTestTb is
-- Deklaration der Signale
    signal Clk     : std_logic := '1';
    signal Start   : std_logic := '0';
    signal Button  : std_logic;
    signal Output  : std_logic;
    signal Green   : std_logic;
    signal Yellow  : std_logic;
    signal Red	   : std_logic;
    
    -- Prozedur Test
    procedure Test(signal   StartBT      : inout std_logic;
                   signal   ButtonBT     : inout std_logic;
                   constant ReactionTime : time             ) is
    begin
        wait for 800 ms;
        StartBT <= '1';         -- gedruckt
        wait for 10 ms;         -- Delay
        StartBT <= '0';         -- ausgelassen
        wait for 5000 ms;       -- Warten bis Output LED erleuchtet
        wait for ReactionTime;  -- Reaktions-Delay
        ButtonBT <= '1';        -- gedruckt
        wait for 10 ms;         -- Delay
        ButtonBT <= '0';        -- Ausgelassen
    end procedure;
 
begin 
    -- Instantieren unseres ReactionTest-Moduls in der Testbench
    i_ReactionTest : entity work.ReactionTest(Rtl)    
    -- Zuweisung von Ports
    port map (
        Clk    => Clk,
        Start  => Start,
        Button =>  Button,
        Output => Output,
        Green  => Green,
        Yellow => Yellow,
        Red    => Red);
 
    -- Generation des PWMs
    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench Sequenz
    process is
    begin
        Test(Start, Button, 20 ms);     -- Grüne LED soll leuchten
        Test(Start, Button, 200 ms);    -- Gelbe LED soll leuchten
        Test(Start, Button, 600 ms);    -- Rote LED soll leuchten
    end process;
 
end architecture;