
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity csm_block is
port (
    p_sum : in std_logic_vector (14 downto 0); --sum from the previous adder row
    p_car : in std_logic_vector(14 downto 0); --carry from previous adder row
    p_ppr : in std_logic_vector(15 downto 0); --previous partial product    
    c_ppr : in std_logic_vector(15 downto 0); -- current partial product
    
    car : out std_logic_vector (14 downto 0); --carry to next adder row
    sum : out std_logic_vector (14 downto 0) --sum vector to next adder row
         );
end csm_block;

architecture csmb_arch of csm_block is
  
COMPONENT FA
port (
    a : in std_logic;
    b : in std_logic;
    ci : in std_logic;
    co : out std_logic;
    sum : out std_logic
         );
END COMPONENT ;

begin

fa0 : FA
   PORT MAP (
   a => p_sum(1),
   b => c_ppr(0),
   ci => p_car(0),
   co => car(0),
   sum => sum(0));
   
fa1 : FA
   PORT MAP (
   a => p_sum(2),
   b => c_ppr(1),
   ci => p_car(1),
   co => car(1),
   sum => sum(1));
   

fa2 : FA
   PORT MAP (
   a => p_sum(3),
   b => c_ppr(2),
   ci => p_car(2),
   co => car(2),
   sum => sum(2));   
   
   
fa3 : FA
   PORT MAP (
   a => p_sum(4),
   b => c_ppr(3),
   ci => p_car(3),
   co => car(3),
   sum => sum(3));
   
fa4 : FA
   PORT MAP (
   a => p_sum(5),
   b => c_ppr(4),
   ci => p_car(4),
   co => car(4),
   sum => sum(4));
   
fa5 : FA
   PORT MAP (
   a => p_sum(6),
   b => c_ppr(5),
   ci => p_car(5),
   co => car(5),
   sum => sum(5));
   
fa6 : FA
   PORT MAP (
   a => p_sum(7),
   b => c_ppr(6),
   ci => p_car(6),
   co => car(6),
   sum => sum(6));
   
   
fa7 : FA
   PORT MAP (
   a => p_sum(8),
   b => c_ppr(7),
   ci => p_car(7),
   co => car(7),
   sum => sum(7));
   
   
fa8 : FA
   PORT MAP (
   a => p_sum(9),
   b => c_ppr(8),
   ci => p_car(8),
   co => car(8),
   sum => sum(8));
   
fa9 : FA
   PORT MAP (
   a => p_sum(10),
   b => c_ppr(9),
   ci => p_car(9),
   co => car(9),
   sum => sum(9));
   
fa10 : FA
   PORT MAP (
   a => p_sum(11),
   b => c_ppr(10),
   ci => p_car(10),
   co => car(10),
   sum => sum(10));
   
fa11 : FA
   PORT MAP (
   a => p_sum(12),
   b => c_ppr(11),
   ci => p_car(11),
   co => car(11),
   sum => sum(11));
   
fa12 : FA
   PORT MAP (
   a => p_sum(13),
   b => c_ppr(12),
   ci => p_car(12),
   co => car(12),
   sum => sum(12));
   
fa13 : FA
   PORT MAP (
   a => p_sum(14),
   b => c_ppr(13),
   ci => p_car(13),
   co => car(13),
   sum => sum(13));
   
fa14 : FA
   PORT MAP (
   a => p_ppr(15),
   b => c_ppr(14),
   ci => p_car(14),
   co => car(14),
   sum => sum(14));

end csmb_arch;
