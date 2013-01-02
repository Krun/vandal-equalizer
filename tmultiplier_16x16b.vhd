library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_multiplier_16x16b is
port (
 valid : out boolean
);
end;

architecture only of test_multiplier_16x16b is

COMPONENT multiplier_16x16b
port (
    sigA : in signed (15 downto 0);
    sigB : in signed (15 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    mult : out signed (31 downto 0)
         );
END COMPONENT ;


SIGNAL sig1 : signed (15 downto 0) := "0000000000000000";
SIGNAL sig2 : signed (15 downto 0) := "0000000000000000";
SIGNAL mout_cs : signed (31 downto 0);
SIGNAL mout_ts : signed (31 downto 0);

begin

mout_ts <= sig1 * sig2;
valid <= (mout_ts - mout_cs) = "00000000000000000000000000000000";

mult : multiplier_16x16b
   PORT MAP (
    sigA => sig1,
    sigB => sig2,
    cin => '0',
    cout => open,
    mult => mout_cs
    );
   
stimulus : PROCESS
   begin
   sig1 <= "0000000000000100";
   sig2 <= "0000000000100000";
   wait for 50 ns;
   sig1 <= "0000001000000100";
   sig2 <= "0000000000000100";
   wait for 50 ns;
   sig1 <= "0000000010001011";
   sig2 <= "0000000100001001";
   wait for 50 ns;
   sig1 <= "0000000010001011";
   sig2 <= "1000000100001001";
   wait for 50 ns;
   sig1 <= "0000000010001011";
   sig2 <= "1100000100001001";
   wait for 50 ns;
   sig1 <= "1100010010001011";
   sig2 <= "1100010100001001";
   wait for 50 ns;
   sig1 <= "1000000010001011";
   sig2 <= "1000000100001001";
   wait for 50 ns;
   sig1 <= "0001000010001011";
   sig2 <= "0001000100001001";
   wait for 50 ns;
   sig1 <= "0000100010001011";
   sig2 <= "0000010100001001";
   wait for 50 ns;
   wait;
end PROCESS stimulus;

end only;