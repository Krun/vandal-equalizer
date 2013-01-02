library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reverb_m is
generic (
    size: integer := 256;
    gain: integer := 100
);
port (
    enable : in bit;
    clk : in bit;
    dataout : out signed(15 downto 0);
    datain : in signed(15 downto 0)
         );
end reverb_m;

architecture revarch_mod of reverb_m is


COMPONENT delay
generic (
    size: integer := 256
);
port (
    clk : in bit;
    dataout : out signed(15 downto 0);
    datain : in signed(15 downto 0)
    );
END COMPONENT ;

COMPONENT multiplier_16x16b
port (
    sigA : in signed (15 downto 0);
    sigB : in signed (15 downto 0);
    mult : out signed (31 downto 0)
         );
END COMPONENT ;

signal gainout : signed (31 downto 0);
signal delayout : signed(15 downto 0);

begin
  

  delay0 : delay
  GENERIC MAP (
    size => size)
  PORT MAP (
    datain => datain,
    dataout => delayout,
    clk => clk
  );
   
  mult0 : multiplier_16x16b
  PORT MAP (
    sigA => delayout,
    sigB => to_signed(gain,16),
    mult => gainout
  );
  
  dataout <= gainout (25 downto 10) when enable = '1' else to_signed(0,16);

end revarch_mod;
   

