library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vumetro_it is
generic (
  defhold : integer := 500
  );
port (
    clk : in bit;
    sin : in signed(15 downto 0);
    sout : out unsigned(7 downto 0)
         );
end vumetro_it;

architecture arch_vumetro_it of vumetro_it is
signal higher : signed (15 downto 0) := to_signed(0,16);
signal hold : integer := defhold;
signal en_updateupdate : bit := '0';

begin
  refresh : process(clk)
  variable sample : signed(15 downto 0) := to_signed(0,16);
  begin
    sample := abs(sin);
    if (clk'event and clk = '1') then
      if (sample > higher OR hold = 0) then
        higher <= sample;
        hold <= defhold;
      else
        hold <= hold -1;
      end if;
    end if;
    
    if    (higher > "0100000000000000") then
      sout <= "11111111";
    elsif (higher > "0001000000000000") then
      sout <= "01111111";
    elsif (higher > "0000010000000000") then
      sout <= "00111111";
    elsif (higher > "0000000100000000") then
      sout <= "00011111";
    elsif (higher > "0000000001000000") then
      sout <= "00001111";
    elsif (higher > "0000000000010000") then
      sout <= "00000111";
    elsif (higher > "0000000000000100") then
      sout <= "00000011";
    elsif (higher > "0000000000000001") then
      sout <= "00000001";
    else
      sout <= "00000000";
    end if;
  end process refresh;

end arch_vumetro_it;
