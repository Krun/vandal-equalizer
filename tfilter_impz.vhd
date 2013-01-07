
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_filter_impz is
end;

architecture only of test_filter_impz is

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

component filehandler is
  generic(
    stim_file: string :="signals\stim_delta.dat";
    log_file: string := "signals\filter0.dat"
    );
  port(
 	  sink : in signed (15 downto 0);
	  source : out signed (15 downto 0);
	  clk : in bit;
	  RST  : in std_logic;
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

SIGNAL clk : bit := '0';
SIGNAL rst : std_logic := '0';
SIGNAL sin : signed (15 downto 0) := "0000000000000000";

begin

  
fh0 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter0.dat")
PORT MAP (
  sink => out0,
	source => sin,
	clk => clk,
	RST => rst,
  EOG => open
	);
	
fh1 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter1.dat")
PORT MAP (
  sink => out1,
	source => open,
	clk => clk,
	RST => rst,
  EOG => open
	);
  
fh2 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter2.dat")
PORT MAP (
  sink => out2,
	source => open,
	clk => clk,
	RST => rst,
  EOG => open
	);
	
fh3 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter3.dat")
PORT MAP (
  sink => out3,
	source => open,
	clk => clk,
	RST => rst,
  EOG => open
	);
	
fh4 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter4.dat")
PORT MAP (
  sink => out4,
	source => open,
	clk => clk,
	RST => rst,
  EOG => open
	);
	
fh5 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter5.dat")
PORT MAP (
  sink => out5,
	source => open,
	clk => clk,
	RST => rst,
  EOG => open
	);
	
fh6 : filehandler
GENERIC MAP (
    stim_file => "signals\stim_delta.dat",
    log_file => "signals\filter6.dat")
PORT MAP (
  sink => out6,
	source => open,
	clk => clk,
	RST => rst,
  EOG => open
	);

fbench0_m : filter_bench_m
  PORT MAP (
  sin => sin,
  clk => clk,
  f_sel => "000",
  g_sel => "0000",
  g_en => '0',
  sout => open,
  sout0 => out0,
  sout1 => out1,
  sout2 => out2,
  sout3 => out3,
  sout4 => out4,
  sout5 => out5,
  sout6 => out6
  );
  
  
  clock : PROCESS
   begin
   wait for 50 ns; clk  <= not clk;
end PROCESS clock;

reset : PROCESS
   begin
   wait for 50 ns; RST  <= '1';
   wait for 10 ns; RST  <= '0';
   wait;
end PROCESS reset;

end only;



