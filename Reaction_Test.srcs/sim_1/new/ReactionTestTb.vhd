library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity ReactionTestTb is
end entity;
 
architecture sim of ReactionTestTb is
 
    -- We're slowing down the clock to speed up simulation time
    constant ClockFrequency : integer := 1000; -- 10 Hz
    constant ClockPeriod      : time := 1000 ms / ClockFrequency; 
 
    signal Clk     : std_logic := '1';
    signal Start   : std_logic := '0';
    signal Button  : std_logic;
    signal Output  : std_logic;
    signal Green   : std_logic;
    signal Yellow  : std_logic;
    signal Red	   : std_logic;
 
begin
 
    -- The Device Under Test (DUT)
    i_ReactionTest : entity work.ReactionTest(Rtl)
    generic map(ClockFrequency => ClockFrequency)
    port map (
        Clk    => Clk,
        Start  => Start,
        Button =>  Button,
        Output => Output,
        Green  => Green,
        Yellow => Yellow,
        Red    => Red);
 
    -- Process for generating the clock
    Clk <= not Clk after ClockPeriod / 2;
 
    -- Testbench sequence
    process is
    begin
        wait for 800 ms;
        Start <= '1';
        wait for 10 ms;
        Start <= '0';
        wait for 6600 ms;
        Button <= '1';
        wait for 10 ms;
        Button <= '0';
        wait for 1000 ms;
--        Start <= '1';
--        wait for 10 ms;
--        Start <= '0';
    end process;
 
end architecture;