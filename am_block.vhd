library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity am_block is
port (
    p_sum : in std_logic_vector (16 downto 0); --sum from the previous adder row. Includes carry bit
    c_ppr : in std_logic_vector(15 downto 0); -- partial product
    sum : out std_logic_vector (16 downto 0) --sum vector to next adder row. Includes carry bit
         );
end am_block;

architecture amb_arch of am_block is
  
COMPONENT FA
port (
    a : in std_logic;
    b : in std_logic;
    ci : in std_logic;
    co : out std_logic;
    sum : out std_logic
         );
END COMPONENT ;
signal carry : std_logic_vector(15 downto 0);
begin

fa0 : FA
   PORT MAP (
   a => p_sum(1),
   b => c_ppr(0),
   ci => '0', -- half adder
   co => carry(0),
   sum => sum(0));
   
fa1 : FA
   PORT MAP (
   a => p_sum(2),
   b => c_ppr(1),
   ci => carry(0),
   co => carry(1),
   sum => sum(1));
   

fa2 : FA
   PORT MAP (
   a => p_sum(3),
   b => c_ppr(2),
   ci => carry(1),
   co => carry(2),
   sum => sum(2));   
   
   
fa3 : FA
   PORT MAP (
   a => p_sum(4),
   b => c_ppr(3),
   ci => carry(2),
   co => carry(3),
   sum => sum(3));
   
fa4 : FA
   PORT MAP (
   a => p_sum(5),
   b => c_ppr(4),
   ci => carry(3),
   co => carry(4),
   sum => sum(4));
   
fa5 : FA
   PORT MAP (
   a => p_sum(6),
   b => c_ppr(5),
   ci => carry(4),
   co => carry(5),
   sum => sum(5));
   
fa6 : FA
   PORT MAP (
   a => p_sum(7),
   b => c_ppr(6),
   ci => carry(5),
   co => carry(6),
   sum => sum(6));
   
   
fa7 : FA
   PORT MAP (
   a => p_sum(8),
   b => c_ppr(7),
   ci => carry(6),
   co => carry(7),
   sum => sum(7));
   
   
fa8 : FA
   PORT MAP (
   a => p_sum(9),
   b => c_ppr(8),
   ci => carry(7),
   co => carry(8),
   sum => sum(8));
   
fa9 : FA
   PORT MAP (
   a => p_sum(10),
   b => c_ppr(9),
   ci => carry(8),
   co => carry(9),
   sum => sum(9));
   
fa10 : FA
   PORT MAP (
   a => p_sum(11),
   b => c_ppr(10),
   ci => carry(9),
   co => carry(10),
   sum => sum(10));
   
fa11 : FA
   PORT MAP (
   a => p_sum(12),
   b => c_ppr(11),
   ci => carry(10),
   co => carry(11),
   sum => sum(11));
   
fa12 : FA
   PORT MAP (
   a => p_sum(13),
   b => c_ppr(12),
   ci => carry(11),
   co => carry(12),
   sum => sum(12));
   
fa13 : FA
   PORT MAP (
   a => p_sum(14),
   b => c_ppr(13),
   ci => carry(12),
   co => carry(13),
   sum => sum(13));
   
fa14 : FA
   PORT MAP (
   a => p_sum(15),
   b => c_ppr(14),
   ci => carry(13),
   co => carry(14),
   sum => sum(14));
   
fa15 : FA
   PORT MAP (
   a => p_sum(16),
   b => c_ppr(15),
   ci => carry(14),
   co => sum(16),
   sum => sum(15));

end amb_arch;

