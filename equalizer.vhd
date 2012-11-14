library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity equalizer is
port (
	sin : in signed (15 downto 0);
	sout : out signed (15 downto 0);
	clk : in bit;
	f_sel : in unsigned (2 downto 0);
	g_sel : in unsigned (3 downto 0);
	g_en : in bit);
end;

architecture equalizer1 of equalizer is

signal g0 : integer := 1024;
signal g1 : integer := 1024;
signal g2 : integer := 1024;
signal g3 : integer := 1024;
signal g4 : integer := 1024;
signal g5 : integer := 1024;
signal g6 : integer := 1024;

signal gn : integer := 1024;

constant gf : integer := 1024;

constant a00 : integer := 1024;
constant a01 : integer := 790;
constant a02 : integer := 610;
constant a03 : integer := 471;
constant a04 : integer := 364;
constant a05 : integer := 281;
constant a06 : integer := 217;
constant a07 : integer := 167;
constant a08 : integer := 129;
constant a09 : integer := 99;
constant a10 : integer := 77;
constant a11 : integer := 59;
constant a12 : integer := 46;
constant a13 : integer := 35;
constant a14 : integer := 27;
constant a15 : integer := 21;

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

signal sum_out1 : signed (31 downto 0);
signal sum_out2 : signed (31 downto 0);

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

begin

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
    a1 => -2009,
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
   
  sum_out1 <= out0*g0 + out1*g1 + out2*g2 + out3*g3 + out4*g4 + out5*g5 + out6*g6;
  sum_out2 <= gf * sum_out1(25 downto 10);
  sout <= sum_out2(25 downto 10);

  select_ganancia : process (g_sel)
    variable gn : integer;
  begin
    if (g_en'event and g_en = '1') then
      CASE g_sel IS
        WHEN  "0000"  =>  gn := a00;
        WHEN  "0001"  =>  gn := a01;
        WHEN  "0010"  =>  gn := a02;
        WHEN  "0011"  =>  gn := a03;
        WHEN  "0100"  =>  gn := a04;
        WHEN  "0101"  =>  gn := a05;
        WHEN  "0110"  =>  gn := a06;
        WHEN  "0111"  =>  gn := a07;
        WHEN  "1000"  =>  gn := a08;
        WHEN  "1001"  =>  gn := a09;
        WHEN  "1010"  =>  gn := a10;
        WHEN  "1011"  =>  gn := a11;
        WHEN  "1100"  =>  gn := a12;
        WHEN  "1101"  =>  gn := a13;
        WHEN  "1110"  =>  gn := a14;
        WHEN  "1111"  =>  gn := a15;  
        WHEN OTHERS =>  gn := gn;
      END CASE;
    
      CASE f_sel IS
        WHEN "000" => g0 <= gn;
        WHEN "001" => g1 <= gn;
        WHEN "010" => g2 <= gn;
        WHEN "011" => g3 <= gn;
        WHEN "100" => g4 <= gn;
        WHEN "101" => g5 <= gn;
        WHEN "110" => g6 <= gn;
        WHEN OTHERS => gn := gn;  
      END CASE;
    end if;
  end process;

end equalizer1;
