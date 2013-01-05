library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_equalizer_system is
end;

architecture only of test_equalizer_system is

signal CLK : bit := '0';
signal sink : signed(15 downto 0);
signal source : signed(15 downto 0);

component filehandler is
  generic(
    stim_file: string :="stimulus.dat";
    log_file: string := "output.dat"
    );
  port(
 	  sink : in signed (15 downto 0);
	  source : out signed (15 downto 0);
	  clk : in bit;
	  RST  : in  std_logic;
    EOG  : out std_logic
	  );
end component;

component equalizer_system is
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
end component;


begin

fh : filehandler

  GENERIC MAP (
    stim_file =>"stimulus.dat",
    log_file => "output.dat")
  PORT MAP (
    sink => sink,
    source => source,
    clk => clk,
    RST => '0',
    EOG => open);
   
es : equalizer_system

  PORT MAP (
    sin => source,
  	 sout => sink,
  	 clk => clk,
  	 f_sel => "000",
  	 g_sel => "0000",
  	 g_en => '0',
  	
  	 rev_en => '0',
  	
  	 level0 => open,
  	 level1 => open,
  	 level2 => open,
  	 level3 => open,
  	 level4 => open,
  	 level5 => open,
  	 level6 => open
  	);

clock : PROCESS
   begin
   wait for 50 ns; clk  <= not clk;
end PROCESS clock;



end only;




