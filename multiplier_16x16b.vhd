
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity multiplier_16x16b is
port (
    sigA : in signed (15 downto 0);
    sigB : in signed (15 downto 0);
    mult : out signed (31 downto 0)
         );
end multiplier_16x16b;

architecture carry_save_arch of multiplier_16x16b is
  
  COMPONENT csm_block is
port (
    p_sum : in std_logic_vector (14 downto 0); --sum from the previous adder row
    p_car : in std_logic_vector(14 downto 0); --carry from previous adder row
    p_ppr : in std_logic_vector(15 downto 0); --previous partial product    
    c_ppr : in std_logic_vector(15 downto 0); -- current partial product
    
    car : out std_logic_vector (14 downto 0); --carry to next adder row
    sum : out std_logic_vector (14 downto 0) --sum vector to next adder row
         );
  end COMPONENT;
  
  COMPONENT csm_lastblock is
port (
    lsum : in std_logic_vector (14 downto 0);
    lcar : in std_logic_vector (14 downto 0);
    resl : out std_logic_vector (15 downto 0)
         );
  end COMPONENT;
  
  signal a_mult : signed(31 downto 0);
  signal a_sigA : signed(15 downto 0);
  signal a_sigB : signed(15 downto 0);
  type memory_type is array (1 to 15) of std_logic_vector(14 downto 0);
  signal carry_vectors : memory_type;   -- array of carry vectors
  signal sum_vectors : memory_type; -- array of sum vectors
  
  
  type memory_type2 is array (0 to 15) of std_logic_vector(15 downto 0); -- array of partial products
  signal ppr_vectors : memory_type2;
  signal lastsum : std_logic_vector(15 downto 0);
  
  signal result_negative : std_logic;
  
  begin
    -- check expected sign of result.
    result_negative <=  sigA(15) XOR sigB(15);
    
    --product will be calculated with absolute values of factors, then sign applied
    a_sigA <= abs(sigA);
    a_sigB <= abs(sigB);
    
  -- Calculate partial products
  ppr_vectors(0) <= std_logic_vector(a_sigA) when a_sigB(0) = '1' else "0000000000000000";
  ppr_vectors(1) <= std_logic_vector(a_sigA) when a_sigB(1) = '1' else "0000000000000000";
  ppr_vectors(2) <= std_logic_vector(a_sigA) when a_sigB(2) = '1' else "0000000000000000";
  ppr_vectors(3) <= std_logic_vector(a_sigA) when a_sigB(3) = '1' else "0000000000000000";
  ppr_vectors(4) <= std_logic_vector(a_sigA) when a_sigB(4) = '1' else "0000000000000000";
  ppr_vectors(5) <= std_logic_vector(a_sigA) when a_sigB(5) = '1' else "0000000000000000";
  ppr_vectors(6) <= std_logic_vector(a_sigA) when a_sigB(6) = '1' else "0000000000000000";
  ppr_vectors(7) <= std_logic_vector(a_sigA) when a_sigB(7) = '1' else "0000000000000000";
  ppr_vectors(8) <= std_logic_vector(a_sigA) when a_sigB(8) = '1' else "0000000000000000";
  ppr_vectors(9) <= std_logic_vector(a_sigA) when a_sigB(9) = '1' else "0000000000000000";
  ppr_vectors(10) <= std_logic_vector(a_sigA) when a_sigB(10) = '1' else "0000000000000000";
  ppr_vectors(11) <= std_logic_vector(a_sigA) when a_sigB(11) = '1' else "0000000000000000";
  ppr_vectors(12) <= std_logic_vector(a_sigA) when a_sigB(12) = '1' else "0000000000000000";
  ppr_vectors(13) <= std_logic_vector(a_sigA) when a_sigB(13) = '1' else "0000000000000000";
  ppr_vectors(14) <= std_logic_vector(a_sigA) when a_sigB(14) = '1' else "0000000000000000";
  ppr_vectors(15) <= std_logic_vector(a_sigA) when a_sigB(15) = '1' else "0000000000000000";
  
  a_mult(0) <= ppr_vectors(0)(0);
  a_mult(1) <= sum_vectors(1)(0);
  a_mult(2) <= sum_vectors(2)(0);
  a_mult(3) <= sum_vectors(3)(0);
  a_mult(4) <= sum_vectors(4)(0);
  a_mult(5) <= sum_vectors(5)(0);
  a_mult(6) <= sum_vectors(6)(0);
  a_mult(7) <= sum_vectors(7)(0);
  a_mult(8) <= sum_vectors(8)(0);
  a_mult(9) <= sum_vectors(9)(0);
  a_mult(10) <= sum_vectors(10)(0);
  a_mult(11) <= sum_vectors(11)(0);
  a_mult(12) <= sum_vectors(12)(0);
  a_mult(13) <= sum_vectors(13)(0);
  a_mult(14) <= sum_vectors(14)(0);
  a_mult(15) <= sum_vectors(15)(0);
  a_mult(31 downto 16) <= signed(lastsum);
  
  mult <= a_mult when result_negative = '0' else -a_mult;
  
  csmb1 : csm_block
  PORT MAP (
    p_sum => "000000000000000",
    p_car => ppr_vectors(0)(15 downto 1),
    p_ppr => "0000000000000000",
    c_ppr => ppr_vectors(1),
    
    car => carry_vectors(1),
    sum => sum_vectors(1)
  );
  
  csmb2 : csm_block
  PORT MAP (
    p_sum => sum_vectors(1),
    p_car => carry_vectors(1),
    p_ppr => ppr_vectors(1),
    c_ppr => ppr_vectors(2),
    car => carry_vectors(2),
    sum => sum_vectors(2)
  );
  
  csmb3 : csm_block
  PORT MAP (
    p_sum => sum_vectors(2),
    p_car => carry_vectors(2),
    p_ppr => ppr_vectors(2),
    c_ppr => ppr_vectors(3),
    car => carry_vectors(3),
    sum => sum_vectors(3)
  );
  
  csmb4 : csm_block
  PORT MAP (
    p_sum => sum_vectors(3),
    p_car => carry_vectors(3),
    p_ppr => ppr_vectors(3),
    c_ppr => ppr_vectors(4),
    car => carry_vectors(4),
    sum => sum_vectors(4)
  );
  
  csmb5 : csm_block
  PORT MAP (
    p_sum => sum_vectors(4),
    p_car => carry_vectors(4),
    p_ppr => ppr_vectors(4),
    c_ppr => ppr_vectors(5),
    car => carry_vectors(5),
    sum => sum_vectors(5)
  );
  
  csmb6 : csm_block
  PORT MAP (
    p_sum => sum_vectors(5),
    p_car => carry_vectors(5),
    p_ppr => ppr_vectors(5),
    c_ppr => ppr_vectors(6),
    car => carry_vectors(6),
    sum => sum_vectors(6)
  );
  
  csmb7 : csm_block
  PORT MAP (
    p_sum => sum_vectors(6),
    p_car => carry_vectors(6),
    p_ppr => ppr_vectors(6),
    c_ppr => ppr_vectors(7),
    car => carry_vectors(7),
    sum => sum_vectors(7)
  );
  
  csmb8 : csm_block
  PORT MAP (
    p_sum => sum_vectors(7),
    p_car => carry_vectors(7),
    p_ppr => ppr_vectors(7),
    c_ppr => ppr_vectors(8),
    car => carry_vectors(8),
    sum => sum_vectors(8)
  );
  
  csmb9 : csm_block
  PORT MAP (
    p_sum => sum_vectors(8),
    p_car => carry_vectors(8),
    p_ppr => ppr_vectors(8),
    c_ppr => ppr_vectors(9),
    car => carry_vectors(9),
    sum => sum_vectors(9)
  );
  
  csmb10 : csm_block
  PORT MAP (
    p_sum => sum_vectors(9),
    p_car => carry_vectors(9),
    p_ppr => ppr_vectors(9),
    c_ppr => ppr_vectors(10),
    car => carry_vectors(10),
    sum => sum_vectors(10)
  );
  
  csmb11 : csm_block
  PORT MAP (
    p_sum => sum_vectors(10),
    p_car => carry_vectors(10),
    p_ppr => ppr_vectors(10),
    c_ppr => ppr_vectors(11),
    car => carry_vectors(11),
    sum => sum_vectors(11)
  );
  
  csmb12 : csm_block
  PORT MAP (
    p_sum => sum_vectors(11),
    p_car => carry_vectors(11),
    p_ppr => ppr_vectors(11),
    c_ppr => ppr_vectors(12),
    car => carry_vectors(12),
    sum => sum_vectors(12)
  );
  
  csmb13 : csm_block
  PORT MAP (
    p_sum => sum_vectors(12),
    p_car => carry_vectors(12),
    p_ppr => ppr_vectors(12),
    c_ppr => ppr_vectors(13),
    car => carry_vectors(13),
    sum => sum_vectors(13)
  );
  
  csmb14 : csm_block
  PORT MAP (
    p_sum => sum_vectors(13),
    p_car => carry_vectors(13),
    p_ppr => ppr_vectors(13),
    c_ppr => ppr_vectors(14),
    car => carry_vectors(14),
    sum => sum_vectors(14)
  );
  
  csmb15 : csm_block
  PORT MAP (
    p_sum => sum_vectors(14),
    p_car => carry_vectors(14),
    p_ppr => ppr_vectors(14),
    c_ppr => ppr_vectors(15),
    car => carry_vectors(15),
    sum => sum_vectors(15)
  );
  
    
  csmlb : csm_lastblock
  PORT MAP (
    lsum => sum_vectors(15),
    lcar => carry_vectors(15),
    resl => lastsum
  );
  
end carry_save_arch;
