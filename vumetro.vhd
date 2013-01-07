--Vumetro combinado de 7 entradas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity vumetro is
generic (
  defhold : integer := 500 --Ciclos de reloj que se mantendran los picos
  );
port (
    clk : in bit;
    sin0 : in signed(15 downto 0);
    sin1 : in signed(15 downto 0);
    sin2 : in signed(15 downto 0);
    sin3 : in signed(15 downto 0);
    sin4 : in signed(15 downto 0);
    sin5 : in signed(15 downto 0);
    sin6 : in signed(15 downto 0);
    out0 : out unsigned(7 downto 0);
    out1 : out unsigned(7 downto 0);
    out2 : out unsigned(7 downto 0);
    out3 : out unsigned(7 downto 0);
    out4 : out unsigned(7 downto 0);
    out5 : out unsigned(7 downto 0);
    out6 : out unsigned(7 downto 0)
         );
end vumetro;

architecture arch_vumetro of vumetro is

COMPONENT vumetro_it
generic (
  defhold : integer := 500
  );
port (
    clk : in bit;
    sin : in signed(15 downto 0);
    sout : out unsigned(7 downto 0)
         );
END COMPONENT ;

begin

vumetro0 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin0,
   clk => clk,
   sout => out0);

vumetro1 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin1,
   clk => clk,
   sout => out1);

vumetro2 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin2,
   clk => clk,
   sout => out2);

vumetro3 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin3,
   clk => clk,
   sout => out3);

vumetro4 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin4,
   clk => clk,
   sout => out4);

vumetro5 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin5,
   clk => clk,
   sout => out5);

vumetro6 : vumetro_it
  GENERIC MAP (
    defhold => defhold)
   PORT MAP (
   sin => sin6,
   clk => clk,
   sout => out6);


end arch_vumetro;
