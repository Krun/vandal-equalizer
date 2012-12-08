library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_vumetro_it is
port (
sout : out unsigned(7 downto 0)
);
end;

architecture only of test_vumetro_it is

COMPONENT vumetro_it
generic (
  defhold : integer := 500
  );
port (
    clk : in bit;
    sin : in signed(15 downto 0);
    sout : out unsigned(7 downto 0)
         );
END COMPONENT ;

SIGNAL clk : bit := '0';
SIGNAL datain : signed (15 downto 0) := "0000000000000000";

begin

vumetro0 : vumetro_it
  GENERIC MAP (
    defhold => 5)
   PORT MAP (
   sin => datain,
   clk => clk,
   sout => sout);

clock : PROCESS
   begin
   wait for 5 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   datain <= "0000000000000000";
   wait for 10 ns; datain  <= "0000000001111111";
   wait for 10 ns; datain  <= "0000000000000000";
   wait for 100 ns; datain <= "0000000001111111";
   wait for 20 ns; datain  <= "0111111111111111";
   wait for 20 ns; datain  <= "0000000001111111";
   wait for 30 ns; datain <=  "1100000000111111";
   wait;
end PROCESS stimulus;

end only;

