library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity csm_lastblock is
port (
    lsum : in std_logic_vector (14 downto 0);
    lcar : in std_logic_vector (14 downto 0);
    resl : out std_logic_vector (15 downto 0)
         );
end csm_lastblock;

architecture ripple_carry_arch of csm_lastblock is
  
COMPONENT FA
port (
    a : in std_logic;
    b : in std_logic;
    ci : in std_logic;
    co : out std_logic;
    sum : out std_logic
         );
END COMPONENT ;
signal carry : std_logic_vector(13 downto 0) := "00000000000000";
begin

fa0 : FA
   PORT MAP (
   a => lsum(1),
   b => lcar(0),
   ci => '0', --half adder
   co => carry(0),
   sum => resl(0));
   
fa1 : FA
   PORT MAP (
   a => lsum(2),
   b => lcar(1),
   ci => carry(0),
   co => carry(1),
   sum => resl(1));
   

fa2 : FA
   PORT MAP (
   a => lsum(3),
   b => lcar(2),
   ci => carry(1),
   co => carry(2),
   sum => resl(2));   
   
   
fa3 : FA
   PORT MAP (
   a => lsum(4),
   b => lcar(3),
   ci => carry(2),
   co => carry(3),
   sum => resl(3));
   
fa4 : FA
   PORT MAP (
   a => lsum(5),
   b => lcar(4),
   ci => carry(3),
   co => carry(4),
   sum => resl(4));
   
fa5 : FA
   PORT MAP (
   a => lsum(6),
   b => lcar(5),
   ci => carry(4),
   co => carry(5),
   sum => resl(5));
   
fa6 : FA
   PORT MAP (
   a => lsum(7),
   b => lcar(6),
   ci => carry(5),
   co => carry(6),
   sum => resl(6));
   
   
fa7 : FA
   PORT MAP (
   a => lsum(8),
   b => lcar(7),
   ci => carry(6),
   co => carry(7),
   sum => resl(7));
   
   
fa8 : FA
   PORT MAP (
   a => lsum(9),
   b => lcar(8),
   ci => carry(7),
   co => carry(8),
   sum => resl(8));
   
fa9 : FA
   PORT MAP (
   a => lsum(10),
   b => lcar(9),
   ci => carry(8),
   co => carry(9),
   sum => resl(9));
   
fa10 : FA
   PORT MAP (
   a => lsum(11),
   b => lcar(10),
   ci => carry(9),
   co => carry(10),
   sum => resl(10));
   
fa11 : FA
   PORT MAP (
   a => lsum(12),
   b => lcar(11),
   ci => carry(10),
   co => carry(11),
   sum => resl(11));
   
fa12 : FA
   PORT MAP (
   a => lsum(13),
   b => lcar(12),
   ci => carry(11),
   co => carry(12),
   sum => resl(12));
   
fa13 : FA
   PORT MAP (
   a => lsum(14),
   b => lcar(13),
   ci => carry(12),
   co => carry(13),
   sum => resl(13));
   
fa14 : FA
   PORT MAP (
   a => '0', --half adder
   b => lcar(14),
   ci => carry(13),
   co => resl(15),
   sum => resl(14));

end ripple_carry_arch;