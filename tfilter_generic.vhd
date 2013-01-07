--Fichero de prueba del filtro genérico con mejoras añadidas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_filter_generic_m is
    PORT (
     		valid0 : out boolean;
     		valid1 : out boolean;
     		valid2 : out boolean;
     		valid3 : out boolean;
     		valid4 : out boolean;
     		valid5 : out boolean;
     		valid6 : out boolean);
end;

architecture only of test_filter_generic_m is

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

signal out0m : signed (15 downto 0);
signal out1m : signed (15 downto 0);
signal out2m : signed (15 downto 0);
signal out3m : signed (15 downto 0);
signal out4m : signed (15 downto 0);
signal out5m : signed (15 downto 0);
signal out6m : signed (15 downto 0);

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

COMPONENT filter_generic_m
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
  
  valid0 <= (out0 - out0m) = to_signed(0,16);
  valid1 <= (out1 - out1m) = to_signed(0,16);
  valid2 <= (out2 - out2m) = to_signed(0,16);
  valid3 <= (out3 - out3m) = to_signed(0,16);
  valid4 <= (out4 - out4m) = to_signed(0,16);
  valid5 <= (out5 - out5m) = to_signed(0,16);
  valid6 <= (out6 - out6m) = to_signed(0,16);

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
   
filter0_m : filter_generic_m
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
   sout => out0m);

filter1_m : filter_generic_m
  GENERIC MAP (
    --gs => 17,
    a1 => -2011,
    a2 => 988)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out1m);

filter2_m : filter_generic_m 
  GENERIC MAP (
    --gs => 34 ,
    a1 => -1970,
    a2 => 955)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out2m);

filter3_m : filter_generic_m 
  GENERIC MAP (
    --gs => 66,
    a1 => -1878,
    a2 => 890)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out3m);
   
filter4_m : filter_generic_m
  GENERIC MAP (
    --gs => 125,
    a1 => -1660,
    a2 => 772)
   PORT MAP (
     sin => sin,
     clk => clk,
     sout => out4m);

filter5_m : filter_generic_m
  GENERIC MAP (
    --gs => 227,
    a1 => -1115,
    a2 => 569)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out5m);

filter6_m : filter_generic_m
  GENERIC MAP (
    --gs => 392,
    a1 => 141,
    a2 => 239)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out6m);

clock : PROCESS
   begin
   wait for 50 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   sin <= "0000000000000000";
   wait for 25 ns; sin  <= "0000010000000000";
   wait for 50 ns; sin  <= "0000000000000000";
   wait;
end PROCESS stimulus;

end only;


