--Fichero de testbench del funcionamiento de reverb

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity test_system_reverb is
end;

architecture only of test_system_reverb is

signal CLK : bit := '0';
signal RST : std_logic := '0';
signal rev : bit := '0';
signal sink : signed(15 downto 0);
signal sink2 : signed(15 downto 0);
signal source : signed(15 downto 0) := "0000000000000000";
signal equal : boolean;

component filehandler is
  generic(
    stim_file: string :="signals/stimulus.dat";
    log_file: string := "signals/output.dat"
    );
  port(
 	  sink : in signed (15 downto 0);
	  source : out signed (15 downto 0);
	  clk : in bit;
	  RST  : in  std_logic;
    EOG  : out std_logic
	  );
end component;

component equalizer_system_m is
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
end component;


begin

fh : filehandler

  GENERIC MAP (
    stim_file =>"signals/short_stim.dat",
    log_file => "signals/reverb.dat")
  PORT MAP (
    sink => sink,
    source => source,
    clk => clk,
    RST => RST,
    EOG => open);
    
fh2 : filehandler

  GENERIC MAP (
    log_file => "signals/reverb2.dat")
  PORT MAP (
    sink => sink2,
    source => open,
    clk => clk,
    RST => '0',
    EOG => open);
    
   
esm2 : equalizer_system_m
  GENERIC MAP(
    reverb_size => 32,
    reverb_gain => 300
  )

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
  	
esm : equalizer_system_m
  GENERIC MAP(
    reverb_size => 32,
    reverb_gain => 300
  )

  PORT MAP (
    sin => source,
  	 sout => sink2,
  	 clk => clk,
  	 f_sel => "000",
  	 g_sel => "0000",
  	 g_en => '0',
  	
  	 rev_en => rev,
  	
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

reset : PROCESS
   begin
   wait for 50 ns; RST  <= '1';
   wait for 10 ns; RST  <= '0';
   wait;
end PROCESS reset;

reverb : PROCESS
   begin
   wait for 200 ns; rev  <= '1';
   wait;
end PROCESS reverb;


end only;





