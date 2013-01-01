library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity carry_bypass_block is
port (
    sigp : in std_logic_vector(3 downto 0);
    sigg : in std_logic_vector(3 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out std_logic_vector(3 downto 0)
         );
end carry_bypass_block;

architecture cbb_arch of carry_bypass_block is
  COMPONENT FA_m is
  port (
      g : in std_logic;
      p : in std_logic;
      ci : in std_logic;
      co : out std_logic;
      sum : out std_logic
         );
  end COMPONENT;
  signal carry : std_logic_vector (3 downto 0);
  signal all_p : std_logic;
begin
  
fa0 : FA_m
   PORT MAP (
   g => sigg(0),
   p => sigp(0),
   ci => cin,
   co => carry(0),
   sum => sum(0));
   
fa1 : FA_m
   PORT MAP (
   g => sigg(1),
   p => sigp(1),
   ci => carry(0),
   co => carry(1),
   sum => sum(1));
   
fa2 : FA_m
   PORT MAP (
   g => sigg(2),
   p => sigp(2),
   ci => carry(1),
   co => carry(2),
   sum => sum(2));
   
fa3 : FA_m
   PORT MAP (
   g => sigg(3),
   p => sigp(3),
   ci => carry(2),
   co => carry(3),
   sum => sum(3));
   
all_p <= sigp(0) AND sigp(1) AND sigp(2) AND sigp(3);

cout <= cin when all_p = '1' else carry(3);

end cbb_arch;