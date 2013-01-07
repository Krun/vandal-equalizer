--Fichero de testbench del filtro genérico

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_filter_generic is
    PORT (
     		iout0 : out integer;
            iout1 : out integer;
            iout2 : out integer;
            iout3 : out integer;
            iout4 : out integer;
            iout5 : out integer;
            iout6 : out integer);
end;

architecture only of test_filter_generic is

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

COMPONENT filter_generic
  generic(
    b0 : integer := 1024;
    b1 : integer := 0;
    b2 : integer := -1024;
    a1 : integer := 1024;
    a2 : integer := 1024;
    gs : integer := 1024);
	port (
		sin : in signed (15 downto 0);
		sout : out signed (15 downto 0);
		clk : in bit);
END COMPONENT ;

SIGNAL clk : bit := '0';
SIGNAL sin : signed (15 downto 0) := "0000000000000000";

begin

iout0 <= to_integer(out0);
iout1 <= to_integer(out1);
iout2 <= to_integer(out2);
iout3 <= to_integer(out3);
iout4 <= to_integer(out4);
iout5 <= to_integer(out5);
iout6 <= to_integer(out6);

filter0 : filter_generic
  GENERIC MAP (
    --Para estudiar la respuesta al impulso,
    --podemos no especificar la ganancia (su valor
    --por defecto es 1)
    --gs => 8,
    a1 => -2029,
    a2 => 1006)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out0);

filter1 : filter_generic 
  GENERIC MAP (
    --gs => 17,
    a1 => -2011,
    a2 => 988)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out1);

filter2 : filter_generic 
  GENERIC MAP (
    --gs => 34 ,
    a1 => -1970,
    a2 => 955)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out2);

filter3 : filter_generic 
  GENERIC MAP (
    --gs => 66,
    a1 => -1878,
    a2 => 890)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out3);
   
filter4 : filter_generic
  GENERIC MAP (
    --gs => 125,
    a1 => -1660,
    a2 => 772)
   PORT MAP (
     sin => sin,
     clk => clk,
     sout => out4);

filter5 : filter_generic
  GENERIC MAP (
    --gs => 227,
    a1 => -1115,
    a2 => 569)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out5);

filter6 : filter_generic
  GENERIC MAP (
    --gs => 392,
    a1 => 141,
    a2 => 239)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out6);

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


