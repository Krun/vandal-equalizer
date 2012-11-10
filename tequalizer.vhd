library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_equalizer is
    PORT (
     		sout : out std_logic_vector (15 downto 0));
end;

architecture only of test_filter is

signal sout0 : std_logic_vector (15 downto 0);
signal sout1 : std_logic_vector (15 downto 0);
signal sout2 : std_logic_vector (15 downto 0);
signal sout3 : std_logic_vector (15 downto 0);
signal sout4 : std_logic_vector (15 downto 0);
signal sout5 : std_logic_vector (15 downto 0);
signal sout6 : std_logic_vector (15 downto 0);

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

COMPONENT equalizer
	port (
	sin : in std_logic_vector (15 downto 0);
	sout : out std_logic_vector (15 downto 0);
	clk : in bit;
	f_sel : in std_logic_vector (2 downto 0);
	g_sel : in std_logic_vector (3 downto 0);
	g_en : in bit);
END COMPONENT ;

SIGNAL clk   : bit := '0';
SIGNAL g_en : bit := '0';
SIGNAL sin  : std_logic_vector (15 downto 0) := "0000000000000000";
SIGNAL f_sel : std_logic_vector (2 downto 0) := "000";
SIGNAL g_sel : std_logic_vector (3 downto 0) := "0000";


begin


eq0 : equalizer 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout,
   f_sel => f_sel,
   g_sel => g_sel,
   g_en => g_en);

clock : PROCESS
   begin
   wait for 10 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   sin <= "0000000000000000";
   wait for 5 ns; sin  <= "0000010000000000";
   wait for 10 ns; sin  <= "0000000000000000";
   wait;
end PROCESS stimulus;

end only;
