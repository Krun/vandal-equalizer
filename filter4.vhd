library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity filter4 is
port (
	sin : in std_logic_vector (15 downto 0);
	sout : out std_logic_vector (15 downto 0);
	clk : in bit);
end;

architecture filterarch4 of filter4 is
	signal historia0 : std_logic_vector (15 downto 0) := conv_std_logic_vector(0,16);
	signal historia1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(0,16);
	--constant b0 : std_logic_vector (15 downto 0) := "0000010000000000";
	constant b0 : std_logic_vector (15 downto 0) := conv_std_logic_vector(1024,16);
	constant b1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(0,16);
	constant b2 : std_logic_vector (15 downto 0) := conv_std_logic_vector(-1024,16);
	constant a1 : std_logic_vector (15 downto 0) := conv_std_logic_vector(-1660,16);
	constant a2 : std_logic_vector (15 downto 0) := conv_std_logic_vector(772,16);
	constant gs : std_logic_vector (15 downto 0) := conv_std_logic_vector(1*1024,16);
	
begin
	filter_proc: process(clk)
		variable sum1 : std_logic_vector (15 downto 0);
		variable sum2 : std_logic_vector (15 downto 0);
		variable mult1 : std_logic_vector (31 downto 0);
		variable mult2 : std_logic_vector (31 downto 0);
		variable mult3 : std_logic_vector (31 downto 0);
		variable mult4 : std_logic_vector (31 downto 0);
		variable mult5 : std_logic_vector (31 downto 0);
		variable mult6 : std_logic_vector (31 downto 0);
	begin
		if (clk'event and clk = '1') then
		  mult1 := b0*sin;
		  mult2 := a1*historia0;
		  mult3 := a2*historia1;
		  mult4 := b1*historia0;
		  mult5 := b2*historia1;
			sum1 := mult1(25 downto 10) - mult2(25 downto 10) - mult3(25 downto 10);
			sum2 := sum1 + mult4(25 downto 10) + mult5(25 downto 10);
			historia1 <= historia0;
			historia0 <= sum1;
			mult6 := gs*sum2;
			sout <= mult6(25 downto 10);
		end if;
	end process;
end filterarch4;

