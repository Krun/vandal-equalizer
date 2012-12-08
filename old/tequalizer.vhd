library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_equalizer is
    PORT (
     		sout : out signed (15 downto 0));
end;

architecture only of test_equalizer is

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

COMPONENT equalizer
port (
	sin : in signed (15 downto 0);
	sout : out signed (15 downto 0);
	clk : in bit;
	f_sel : in unsigned (2 downto 0);
	g_sel : in unsigned (3 downto 0);
	g_en : in bit);
END COMPONENT ;

SIGNAL clk   : bit := '0';
SIGNAL g_en : bit := '0';
SIGNAL sin  : signed (15 downto 0) := "0000000000000000";
SIGNAL f_sel : unsigned (2 downto 0) := "000";
SIGNAL g_sel : unsigned (3 downto 0) := "0000";


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
   wait for 10 ns; 
   clk  <= not clk;
   g_en <= not g_en;
end PROCESS clock;

g_sel_p : PROCESS
   begin
   wait for 10 ns; g_sel <= g_sel + 1;
end PROCESS g_sel_p;

f_sel_p : PROCESS
  begin
  wait for 160 ns; f_sel <= f_sel +1;
end PROCESS f_sel_p;


end only;
