--Sistema de banco de filtros con mejoras añadidas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter_bench_m is
port (
  sin : in signed (15 downto 0);
  clk : in bit;
  f_sel : in unsigned (2 downto 0);
  g_sel : in unsigned (3 downto 0);
  g_en : in bit;
  
  sout  : out signed (15 downto 0);
  
  sout0 : out signed (15 downto 0);
  sout1 : out signed (15 downto 0);
  sout2 : out signed (15 downto 0);
  sout3 : out signed (15 downto 0);
  sout4 : out signed (15 downto 0);
  sout5 : out signed (15 downto 0);
  sout6 : out signed (15 downto 0)
  );
end filter_bench_m;

architecture bench1 of filter_bench_m is

signal g0 : signed(15 downto 0) := to_signed(1024,16);
signal g1 : signed(15 downto 0) := to_signed(1024,16);
signal g2 : signed(15 downto 0) := to_signed(1024,16);
signal g3 : signed(15 downto 0) := to_signed(1024,16);
signal g4 : signed(15 downto 0) := to_signed(1024,16);
signal g5 : signed(15 downto 0) := to_signed(1024,16);
signal g6 : signed(15 downto 0) := to_signed(1024,16);

signal gn : signed(15 downto 0) := to_signed(1024,16);

constant gf : signed(15 downto 0) := to_signed(1024,16);

constant a00 : signed(15 downto 0) := to_signed(1024,16);
constant a01 : signed(15 downto 0) := to_signed(790,16);
constant a02 : signed(15 downto 0) := to_signed(610,16);
constant a03 : signed(15 downto 0) := to_signed(471,16);
constant a04 : signed(15 downto 0) := to_signed(364,16);
constant a05 : signed(15 downto 0) := to_signed(281,16);
constant a06 : signed(15 downto 0) := to_signed(217,16);
constant a07 : signed(15 downto 0) := to_signed(167,16);
constant a08 : signed(15 downto 0) := to_signed(129,16);
constant a09 : signed(15 downto 0) := to_signed(99,16);
constant a10 : signed(15 downto 0) := to_signed(77,16);
constant a11 : signed(15 downto 0) := to_signed(59,16);
constant a12 : signed(15 downto 0) := to_signed(46,16);
constant a13 : signed(15 downto 0) := to_signed(35,16);
constant a14 : signed(15 downto 0) := to_signed(27,16);
constant a15 : signed(15 downto 0) := to_signed(21,16);

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

signal gout0 : signed (31 downto 0);
signal gout1 : signed (31 downto 0);
signal gout2 : signed (31 downto 0);
signal gout3 : signed (31 downto 0);
signal gout4 : signed (31 downto 0);
signal gout5 : signed (31 downto 0);
signal gout6 : signed (31 downto 0);

signal gout_o : signed (31 downto 0);

signal suma1 : signed (15 downto 0);
signal suma2 : signed (15 downto 0);
signal suma3 : signed (15 downto 0);
signal suma4 : signed (15 downto 0);
signal suma5 : signed (15 downto 0);
signal suma6 : signed (15 downto 0);

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

	COMPONENT multiplier_16x16b
	port (
    sigA : in signed (15 downto 0);
    sigB : in signed (15 downto 0);
    mult : out signed (31 downto 0)
  );
  END COMPONENT;
  
  COMPONENT adder_16b
  port (
    sig1 : in signed (15 downto 0);
    sig2 : in signed (15 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out signed (15 downto 0)
  );
  END COMPONENT;

begin

filter0 : filter_generic_m
  GENERIC MAP (
    gs => 8,
    a1 => -2029,
    a2 => 1006)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out0);

filter1 : filter_generic_m 
  GENERIC MAP (
    gs => 17,
    a1 => -2009,
    a2 => 988)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out1);

filter2 : filter_generic_m 
  GENERIC MAP (
    gs => 34 ,
    a1 => -1970,
    a2 => 955)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out2);

filter3 : filter_generic_m 
  GENERIC MAP (
    gs => 66,
    a1 => -1878,
    a2 => 890)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out3);
   
filter4 : filter_generic_m
  GENERIC MAP (
    gs => 125,
    a1 => -1660,
    a2 => 772)
   PORT MAP (
     sin => sin,
     clk => clk,
     sout => out4);

filter5 : filter_generic_m
  GENERIC MAP (
    gs => 227,
    a1 => -1115,
    a2 => 569)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out5);

filter6 : filter_generic_m
  GENERIC MAP (
    gs => 392,
    a1 => 141,
    a2 => 239)
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => out6);
   

   
   mult0 : multiplier_16x16b
   PORT MAP(
     sigA => out0,
     sigB => g0,
     mult => gout0
   );
   
   mult1 : multiplier_16x16b
   PORT MAP(
     sigA => out1,
     sigB => g1,
     mult => gout1
   );
   
   mult2 : multiplier_16x16b
   PORT MAP(
     sigA => out2,
     sigB => g2,
     mult => gout2
   );
   
   mult3 : multiplier_16x16b
   PORT MAP(
     sigA => out3,
     sigB => g3,
     mult => gout3
   );
   
   mult4 : multiplier_16x16b
   PORT MAP(
     sigA => out4,
     sigB => g4,
     mult => gout4
   );
   
   mult5 : multiplier_16x16b
   PORT MAP(
     sigA => out5,
     sigB => g5,
     mult => gout5
   );
   
   mult6 : multiplier_16x16b
   PORT MAP(
     sigA => out6,
     sigB => g6,
     mult => gout6
   );
   
   
   
   
   add1 : adder_16b
   PORT MAP(
     sig1 => gout0(25 downto 10),
     sig2 => gout1(25 downto 10),
     cin => '0',
     cout => open,
     sum => suma1
   );
   add2 : adder_16b
   PORT MAP(
     sig1 => suma1,
     sig2 => gout2(25 downto 10),
     cin => '0',
     cout => open,
     sum => suma2
   );
   
   add3 : adder_16b
   PORT MAP(
     sig1 => suma2,
     sig2 => gout3(25 downto 10),
     cin => '0',
     cout => open,
     sum => suma3
   );
   add4 : adder_16b
   PORT MAP(
     sig1 => suma3,
     sig2 => gout4(25 downto 10),
     cin => '0',
     cout => open,
     sum => suma4
   );
   add5 : adder_16b
   PORT MAP(
     sig1 => suma4,
     sig2 => gout5(25 downto 10),
     cin => '0',
     cout => open,
     sum => suma5
   );
   add6 : adder_16b
   PORT MAP(
     sig1 => suma5,
     sig2 => gout6(25 downto 10),
     cin => '0',
     cout => open,
     sum => suma6
   );
   
   mult_out : multiplier_16x16b
   PORT MAP(
     sigA => suma6,
     sigB => gf,
     mult => gout_o
   );


  -- Sumadores y multiplicadores hacen lo siguiente:
  --
  --  gout0 <= out0*g0;
  --  gout1 <= out1*g1;
  --  gout2 <= out2*g2;
  --  gout3 <= out3*g3;
  --  gout4 <= out4*g4;
  --  gout5 <= out5*g5;
  --  gout6 <= out6*g6;
  --
  -- suma1 <= gout0(25 downto 10) + gout1(25 downto 10);
  -- suma2 <= suma1 + gout2(25 downto 10);
  -- suma3 <= suma2 + gout3(25 downto 10);
  -- suma4 <= suma3 + gout4(25 downto 10);
  -- suma5 <= suma4 + gout5(25 downto 10);
  -- suma6 <= suma5 + gout6(25 downto 10);
  -- (suma6 = gout0 + gout1 + gout2 + gout3 + gout4 + gout5 + gout6)
  --
  -- gout_o <= suma6*gf
  

  
  

  select_ganancia : process (g_en)
    variable gn : signed(15 downto 0);
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
  
  clock_s : process(clk)
begin
  if (clk'event and clk = '1') then
    sout <= gout_o(25 downto 10);
    sout0 <= gout0(25 downto 10);
    sout1 <= gout1(25 downto 10);
    sout2 <= gout2(25 downto 10);
    sout3 <= gout3(25 downto 10);
    sout4 <= gout4(25 downto 10);
    sout5 <= gout5(25 downto 10);
    sout6 <= gout6(25 downto 10);
  end if;
end process;

end bench1;
