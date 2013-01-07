library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FA is
port (
    a : in std_logic;
    b : in std_logic;
    ci : in std_logic;
    co : out std_logic;
    sum : out std_logic
         );
end FA;

architecture full_adder_arch of FA is
begin
  sum <= transport a XOR b XOR ci after 1 ns;
  co <= transport (a AND b) OR (b AND ci) OR (a AND ci) after 1 ns;
end full_adder_arch;