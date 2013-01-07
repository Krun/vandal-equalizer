library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_16b is
port (
    sig1 : in signed (15 downto 0);
    sig2 : in signed (15 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out signed (15 downto 0)
         );
end adder_16b;

architecture ripple_carry_arch of adder_16b is
  
COMPONENT FA
port (
    a : in std_logic;
    b : in std_logic;
    ci : in std_logic;
    co : out std_logic;
    sum : out std_logic
         );
END COMPONENT ;
signal carry : std_logic_vector(14 downto 0) := "000000000000000";

begin

fa0 : FA
   PORT MAP (
   a => sig1(0),
   b => sig2(0),
   ci => cin,
   co => carry(0),
   sum => sum(0));
   
fa1 : FA
   PORT MAP (
   a => sig1(1),
   b => sig2(1),
   ci => carry(0),
   co => carry(1),
   sum => sum(1));
   

fa2 : FA
   PORT MAP (
   a => sig1(2),
   b => sig2(2),
   ci => carry(1),
   co => carry(2),
   sum => sum(2));   
   
   
fa3 : FA
   PORT MAP (
   a => sig1(3),
   b => sig2(3),
   ci => carry(2),
   co => carry(3),
   sum => sum(3));
   
fa4 : FA
   PORT MAP (
   a => sig1(4),
   b => sig2(4),
   ci => carry(3),
   co => carry(4),
   sum => sum(4));
   
fa5 : FA
   PORT MAP (
   a => sig1(5),
   b => sig2(5),
   ci => carry(4),
   co => carry(5),
   sum => sum(5));
   
fa6 : FA
   PORT MAP (
   a => sig1(6),
   b => sig2(6),
   ci => carry(5),
   co => carry(6),
   sum => sum(6));
   
   
fa7 : FA
   PORT MAP (
   a => sig1(7),
   b => sig2(7),
   ci => carry(6),
   co => carry(7),
   sum => sum(7));
   
   
fa8 : FA
   PORT MAP (
   a => sig1(8),
   b => sig2(8),
   ci => carry(7),
   co => carry(8),
   sum => sum(8));
   
fa9 : FA
   PORT MAP (
   a => sig1(9),
   b => sig2(9),
   ci => carry(8),
   co => carry(9),
   sum => sum(9));
   
fa10 : FA
   PORT MAP (
   a => sig1(10),
   b => sig2(10),
   ci => carry(9),
   co => carry(10),
   sum => sum(10));
   
fa11 : FA
   PORT MAP (
   a => sig1(11),
   b => sig2(11),
   ci => carry(10),
   co => carry(11),
   sum => sum(11));
   
fa12 : FA
   PORT MAP (
   a => sig1(12),
   b => sig2(12),
   ci => carry(11),
   co => carry(12),
   sum => sum(12));
   
fa13 : FA
   PORT MAP (
   a => sig1(13),
   b => sig2(13),
   ci => carry(12),
   co => carry(13),
   sum => sum(13));
   
fa14 : FA
   PORT MAP (
   a => sig1(14),
   b => sig2(14),
   ci => carry(13),
   co => carry(14),
   sum => sum(14));
   
fa15 : FA
   PORT MAP (
   a => sig1(15),
   b => sig2(15),
   ci => carry(14),
   co => cout,
   sum => sum(15));

end ripple_carry_arch;

architecture carry_bypass_arch of adder_16b is
  signal sigp : std_logic_vector(15 downto 0) := "0000000000000000";
  signal sigg : std_logic_vector(15 downto 0) := "0000000000000000";
  signal carry : std_logic_vector(2 downto 0) := "000";
  signal sum_v : std_logic_vector(15 downto 0);
  COMPONENT carry_bypass_block is
    port (
        sigp : in std_logic_vector(3 downto 0);
        sigg : in std_logic_vector(3 downto 0);
        cin : in std_logic;
        cout : out std_logic;
        sum : out std_logic_vector(3 downto 0)
         );
  end COMPONENT;
  begin
    sigg <= std_logic_vector(sig1) AND std_logic_vector(sig2);
    sigp <= std_logic_vector(sig1) XOR std_logic_vector(sig2);
    sum <= signed(sum_v);
    
cbb0 : carry_bypass_block
   PORT MAP (
   sigp => sigp(3 downto 0),
   sigg => sigg(3 downto 0),
   cin => cin,
   cout => carry(0),
   sum => sum_v(3 downto 0));
   
cbb1 : carry_bypass_block
   PORT MAP (
   sigp => sigp(7 downto 4),
   sigg => sigg(7 downto 4),
   cin => carry(0),
   cout => carry(1),
   sum => sum_v(7 downto 4));
   
cbb2 : carry_bypass_block
   PORT MAP (
   sigp => sigp(11 downto 8),
   sigg => sigg(11 downto 8),
   cin => carry(1),
   cout => carry(2),
   sum => sum_v(11 downto 8));
   
cbb3 : carry_bypass_block
   PORT MAP (
   sigp => sigp(15 downto 12),
   sigg => sigg(15 downto 12),
   cin => carry(2),
   cout => cout,
   sum => sum_v(15 downto 12)); 
  
end carry_bypass_arch;