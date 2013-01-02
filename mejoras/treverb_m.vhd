library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_reverb_m is
port (
sout : out signed(15 downto 0);
sout2 : out signed(15 downto 0)
);
end;

architecture only of test_reverb_m is

COMPONENT reverb
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
END COMPONENT ;

COMPONENT reverb_m
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
END COMPONENT ;

SIGNAL clk : bit := '0';
SIGNAL datain : signed (15 downto 0) := "0000000000000000";

begin
  reverb0 : reverb_m
  GENERIC MAP (
    size => 5,
    gain => 128)
  PORT MAP (
    enable => '1',
    datain => datain,
    clk => clk,
    dataout => sout
  );
  
  reverb1 : reverb
  GENERIC MAP (
    size => 5,
    gain => 128)
  PORT MAP (
    enable => '1',
    datain => datain,
    clk => clk,
    dataout => sout2
  );
  

clock : PROCESS
   begin
   wait for 10 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   datain <= "0000000000000000";
   wait for 25 ns; datain  <= "0000111111111111";
   wait for 50 ns; datain  <= "1000000001111111";
   wait for 100 ns; datain <= "0000000000000000";
   wait;
end PROCESS stimulus;

end only;


