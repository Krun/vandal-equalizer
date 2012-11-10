library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity equalizer is
port (
	sin : in std_logic_vector (15 downto 0);
	sout : out std_logic_vector (15 downto 0);
	clk : in bit;
	f_sel : in std_logic_vector (2 downto 0);
	g_sel : in std_logic_vector (3 downto 0);
	g_en : in bit);
end;

architecture equalizer1 of equalizer is

signal g0 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
signal g1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
signal g2 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
signal g3 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
signal g4 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
signal g5 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
signal g6 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);

signal gn : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);

constant gf : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);

constant a00 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
constant a01 : std_logic_vector (15 downto 0) := conv_std_logic_vector(790,16);
constant a02 : std_logic_vector (15 downto 0) := conv_std_logic_vector(610,16);
constant a03 : std_logic_vector (15 downto 0) := conv_std_logic_vector(471,16);
constant a04 : std_logic_vector (15 downto 0) := conv_std_logic_vector(364,16);
constant a05 : std_logic_vector (15 downto 0) := conv_std_logic_vector(281,16);
constant a06 : std_logic_vector (15 downto 0) := conv_std_logic_vector(217,16);
constant a07 : std_logic_vector (15 downto 0) := conv_std_logic_vector(167,16);
constant a08 : std_logic_vector (15 downto 0) := conv_std_logic_vector(129,16);
constant a09 : std_logic_vector (15 downto 0) := conv_std_logic_vector(99,16);
constant a10 : std_logic_vector (15 downto 0) := conv_std_logic_vector(77,16);
constant a11 : std_logic_vector (15 downto 0) := conv_std_logic_vector(59,16);
constant a12 : std_logic_vector (15 downto 0) := conv_std_logic_vector(46,16);
constant a13 : std_logic_vector (15 downto 0) := conv_std_logic_vector(35,16);
constant a14 : std_logic_vector (15 downto 0) := conv_std_logic_vector(27,16);
constant a15 : std_logic_vector (15 downto 0) := conv_std_logic_vector(21,16);

signal sout0 : std_logic_vector (15 downto 0);
signal sout1 : std_logic_vector (15 downto 0);
signal sout2 : std_logic_vector (15 downto 0);
signal sout3 : std_logic_vector (15 downto 0);
signal sout4 : std_logic_vector (15 downto 0);
signal sout5 : std_logic_vector (15 downto 0);
signal sout6 : std_logic_vector (15 downto 0);

signal sum_out1 : std_logic_vector (31 downto 0);
signal sum_out2 : std_logic_vector (31 downto 0);

COMPONENT filter0
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter1
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter2
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter3
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter4
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter5
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter6
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

begin
  
band0 : filter0 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout0);

band1 : filter1 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout1);

band2 : filter2 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout2);

band3 : filter3 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout3);
   
band4 : filter4
   PORT MAP (
     sin => sin,
     clk => clk,
     sout => sout4);

band5 : filter5
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout5);

band6 : filter6 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout6);
   
  sum_out1 <= sout0*g0 + sout1*g1 + sout2*g2 + sout3*g3 + sout4*g4 + sout5*g5 + sout6*g6;
  sum_out2 <= gf * sum_out1(25 downto 10);
  sout <= sum_out2(25 downto 10);

  select_ganancia : process (g_sel)
    variable gn : std_logic_vector (15 downto 0);
  begin
    if (g_en'event and g_en = '1') then
      CASE g_sel IS
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
        WHEN OTHERS =>  gn := a00;
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