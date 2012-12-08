library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_delay is
port (
sout : out signed(15 downto 0)
);
end;

architecture only of test_delay is

COMPONENT delay
  generic(
    size : integer := 256);
  port (
    clk : in bit;
    dataout : out signed(15 downto 0);
    datain : in signed(15 downto 0)
  );
END COMPONENT ;

SIGNAL clk : bit := '0';
SIGNAL datain : signed (15 downto 0) := "0000000000000000";

begin

delay0 : delay
  GENERIC MAP (
    size => 5)
   PORT MAP (
   datain => datain,
   clk => clk,
   dataout => sout);

clock : PROCESS
   begin
   wait for 10 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   datain <= "0000000000000000";
   wait for 5 ns; datain  <= "1111111111111111";
   wait for 10 ns; datain  <= "0000000001111111";
   wait;
end PROCESS stimulus;

end only;

