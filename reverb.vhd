library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reverb is
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
end reverb;

architecture revarch of reverb is
signal gainout : signed(31 downto 0);
signal delayout : signed(15 downto 0);

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

begin

delay0 : delay
  GENERIC MAP (
    size => size)
   PORT MAP (
   datain => datain,
   dataout => delayout,
   clk => clk);
   
gainout <= delayout * gain;
dataout <= gainout (25 downto 10) when enable = '1' else to_signed(0,16);

end revarch;
   

