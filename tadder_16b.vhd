library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_adder_16b is
port (
 valid : out boolean
);
end;

architecture only of test_adder_16b is

COMPONENT adder_16b
  port (
    sig1 : in signed (15 downto 0);
    sig2 : in signed (15 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out signed (15 downto 0)
         );
END COMPONENT ;

for add_ripple_carry : adder_16b use entity work.adder_16b(ripple_carry_arch);
for add_carry_bypass : adder_16b use entity work.adder_16b(carry_bypass_arch);

SIGNAL sig1 : signed (15 downto 0) := "0000000000000000";
SIGNAL sig2 : signed (15 downto 0) := "0000000000000000";
SIGNAL sout_rc : signed (15 downto 0);
SIGNAL sout_cb : signed (15 downto 0);
SIGNAL sout_ts : signed (15 downto 0);

begin

sout_ts <= sig1 + sig2;
valid <= ((sout_rc - sout_ts) OR (sout_rc - sout_ts)) = "0000000000000000";

add_ripple_carry : adder_16b
   PORT MAP (
   sig1 => sig1,
   sig2 => sig2,
   sum => sout_rc,
   cin => '0',
   cout => open);
   
add_carry_bypass : adder_16b
   PORT MAP (
   sig1 => sig1,
   sig2 => sig2,
   sum => sout_cb,
   cin => '0',
   cout => open);

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

configuration sel of test_adder_16b is
for only
for add_ripple_carry : adder_16b use entity work.adder_16b(ripple_carry_arch);
end for;
for add_carry_bypass : adder_16b use entity work.adder_16b(carry_bypass_arch);
end for;
end for;
end sel;
