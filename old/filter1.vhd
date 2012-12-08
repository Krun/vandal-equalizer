library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity filter1 is
port (
	sin : in std_logic_vector (15 downto 0);
	sout : out std_logic_vector (15 downto 0);
	clk : in bit);
end;

architecture filterarch1 of filter1 is
	signal historia0 : std_logic_vector (15 downto 0) := conv_std_logic_vector(0,16);
	signal historia1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(0,16);
	constant b0 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
	constant b1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(0,16);
	constant b2 : std_logic_vector (15 downto 0) := conv_std_logic_vector(-1024,16);
	constant a1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(-2009,16);
	constant a2 : std_logic_vector (15 downto 0) := conv_std_logic_vector(988,16);
	constant gs : std_logic_vector (15 downto 0) := conv_std_logic_vector(1*1024,16);
	
begin
	filter_proc: process(clk)
		variable sum1 : std_logic_vector (31 downto 0);
		variable sum2 : std_logic_vector (31 downto 0);
		variable mult : std_logic_vector (31 downto 0);

	begin
		if (clk'event and clk = '1') then
			sum1 := b0*sin - a1*historia0 - a2*historia1;
			sum2 := sum1 + b1*historia0 + b2*historia1;
			historia1 <= historia0;
			historia0 <= sum1(25 downto 10);
			mult := gs*sum2(25 downto 10);
			sout <= mult(25 downto 10);
		end if;
	end process;
end filterarch1;

