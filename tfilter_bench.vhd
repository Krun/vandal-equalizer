
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_filter_bench is
  port(
    valid : out boolean;
    valid0 : out boolean;
    valid1 : out boolean;
    valid2 : out boolean;
    valid3 : out boolean;
    valid4 : out boolean;
    valid5 : out boolean;
    valid6 : out boolean
  );
  
end;

architecture only of test_filter_bench is

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);
signal outt : signed (15 downto 0);

signal out0_m : signed (15 downto 0);
signal out1_m : signed (15 downto 0);
signal out2_m : signed (15 downto 0);
signal out3_m : signed (15 downto 0);
signal out4_m : signed (15 downto 0);
signal out5_m : signed (15 downto 0);
signal out6_m : signed (15 downto 0);
signal outt_m : signed (15 downto 0);

signal source : signed (15 downto 0);

component filehandler is
  generic(
    stim_file: string :="stimulus.dat";
    log_file: string := "dummy"
    );
  port(
 	  sink : in signed (15 downto 0);
	  source : out signed (15 downto 0);
	  clk : in bit;
	  RST  : in  std_logic;
    EOG  : out std_logic
	  );
end component;

component filter_bench_m is
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

SIGNAL clk : bit := '0';
SIGNAL sin : signed (15 downto 0) := "0000000000000000";

signal tout : signed (15 downto 0);
signal tout0 : signed (15 downto 0);
signal tout1 : signed (15 downto 0);
signal tout2 : signed (15 downto 0);
signal tout3 : signed (15 downto 0);
signal tout4 : signed (15 downto 0);
signal tout5 : signed (15 downto 0);
signal tout6 : signed (15 downto 0);

begin
  valid <= outt = outt_m;
  valid0 <= out0 = out0_m;
  valid1 <= out1 = out1_m;
  valid2 <= out2 = out2_m;
  valid3 <= out3 = out3_m;
  valid4 <= out4 = out4_m;
  valid5 <= out5 = out5_m;
  valid6 <= out6 = out6_m;
  
  --compensamos el retardo de 1 ciclo de reloj del modificado
  outt <= tout after 100 ns;
  out0 <= tout0 after 100 ns;
  out1 <= tout1 after 100 ns;
  out2 <= tout2 after 100 ns;
  out3 <= tout3 after 100 ns;
  out4 <= tout4 after 100 ns;
  out5 <= tout5 after 100 ns;
  out6 <= tout6 after 100 ns;
  
fh : filehandler
GENERIC MAP (
    stim_file =>"stimulus.dat",
    log_file => "dummy")
PORT MAP (
  sink => "0000000000000000",
	source => sin,
	clk => clk,
	RST => '0',
  EOG => open
	);
  


fbench0_m : filter_bench_m
  PORT MAP (
  sin => sin,
  clk => clk,
  f_sel => "000",
  g_sel => "0000",
  g_en => '0',
  sout => outt_m,
  sout0 => out0_m,
  sout1 => out1_m,
  sout2 => out2_m,
  sout3 => out3_m,
  sout4 => out4_m,
  sout5 => out5_m,
  sout6 => out6_m
  );
  
fbench0 : filter_bench
  PORT MAP (
  sin => sin,
  clk => clk,
  f_sel => "000",
  g_sel => "0000",
  g_en => '0',
  sout => tout,
  sout0 => tout0,
  sout1 => tout1,
  sout2 => tout2,
  sout3 => tout3,
  sout4 => tout4,
  sout5 => tout5,
  sout6 => tout6
  );
  
  clock : PROCESS
   begin
   wait for 50 ns; clk  <= not clk;
end PROCESS clock;

end only;



