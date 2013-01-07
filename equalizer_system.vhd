--
--Sistema de ecualización
--Esta entidad agrupa todos los subsistemas


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity equalizer_system is
  generic (
  reverb_size : integer := 256;
  reverb_gain : integer := 100
  );
port (
	sin : in signed (15 downto 0);
	sout : out signed (15 downto 0);
	clk : in bit;
	f_sel : in unsigned (2 downto 0);
	g_sel : in unsigned (3 downto 0);
	g_en : in bit;
	
	rev_en : in bit;
	
	level0 : out unsigned (7 downto 0);
	level1 : out unsigned (7 downto 0);
	level2 : out unsigned (7 downto 0);
	level3 : out unsigned (7 downto 0);
	level4 : out unsigned (7 downto 0);
	level5 : out unsigned (7 downto 0);
	level6 : out unsigned (7 downto 0)
	);
end equalizer_system;

architecture whole of equalizer_system is

signal f0_out : signed (15 downto 0) := to_signed(0,16);
signal f1_out : signed (15 downto 0) := to_signed(0,16);
signal f2_out : signed (15 downto 0) := to_signed(0,16);
signal f3_out : signed (15 downto 0) := to_signed(0,16);
signal f4_out : signed (15 downto 0) := to_signed(0,16);
signal f5_out : signed (15 downto 0) := to_signed(0,16);
signal f6_out : signed (15 downto 0) := to_signed(0,16);
signal fb_out : signed (15 downto 0) := to_signed(0,16);
signal rv_out : signed (15 downto 0) := to_signed(0,16);
signal fb_in : signed (15 downto 0) := to_signed(0,16);

component filter_bench is
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
end component;

component reverb is
generic (
    size: integer := 256;
    gain: integer := 100
);
port (
    enable : in bit;
    clk : in bit;
    dataout : out signed(15 downto 0);
    datain : in signed(15 downto 0)
         );
end component;

component vumetro is
generic (
  defhold : integer := 500 --Ciclos de reloj que se mantendran los picos
  );
port (
    clk : in bit;
    sin0 : in signed(15 downto 0);
    sin1 : in signed(15 downto 0);
    sin2 : in signed(15 downto 0);
    sin3 : in signed(15 downto 0);
    sin4 : in signed(15 downto 0);
    sin5 : in signed(15 downto 0);
    sin6 : in signed(15 downto 0);
    out0 : out unsigned(7 downto 0);
    out1 : out unsigned(7 downto 0);
    out2 : out unsigned(7 downto 0);
    out3 : out unsigned(7 downto 0);
    out4 : out unsigned(7 downto 0);
    out5 : out unsigned(7 downto 0);
    out6 : out unsigned(7 downto 0)
         );
end component;

begin

fb_in <= rv_out + sin;
sout <= fb_out;

reverb0 : reverb
  GENERIC MAP (
    size => reverb_size,
    gain => reverb_gain)
   PORT MAP (
   enable => rev_en,
   datain => fb_out,
   dataout => rv_out,
   clk => clk);
   
fbench0 : filter_bench
  PORT MAP (
  sin => fb_in,
  clk => clk,
  f_sel => f_sel,
  g_sel => g_sel,
  g_en => g_en,
  sout => fb_out,
  sout0 => f0_out,
  sout1 => f1_out,
  sout2 => f2_out,
  sout3 => f3_out,
  sout4 => f4_out,
  sout5 => f5_out,
  sout6 => f6_out
  );

vumetro0 : vumetro
  GENERIC MAP (
    defhold => 500)
  PORT MAP (
    clk => clk,
    sin0 => f0_out,
    sin1 => f1_out,
    sin2 => f2_out,
    sin3 => f3_out,
    sin4 => f4_out,
    sin5 => f5_out,
    sin6 => f6_out,
    out0 => level0,
    out1 => level1,
    out2 => level2,
    out3 => level3,
    out4 => level4,
    out5 => level5,
    out6 => level6
    );
end whole;
