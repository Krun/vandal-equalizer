--Full adder modificado para trabajar con señales P y G

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FA_m is
port (
    g : in std_logic;
    p : in std_logic;
    ci : in std_logic;
    co : out std_logic;
    sum : out std_logic
         );
end FA_m;

architecture full_adder_modified_arch of FA_m is

begin
  sum <= p XOR ci after 1 ns;
  co <= g OR (p AND ci) after 1 ns;
end full_adder_modified_arch;
