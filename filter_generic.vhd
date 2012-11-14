library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter_generic is
  -- utilizamos genericos para poder reutilizar
  -- la implementación del filtro con los distintos valores
  -- de coeficientes
  generic(
    -- Los coeficientes estan escalados por 1024, lo que
    -- corresponde a utilizar una representación en coma
    -- binaria de 6 bits enteros y 10 fraccionarios
    b0 : integer := 1024;
    b1 : integer := 0;
    b2 : integer := -1024;
    a1 : integer := 1024;
    a2 : integer := 1024;
    gs : integer := 1024);
  port (
	 sin : in signed (15 downto 0);
	 sout : out signed (15 downto 0);
	 clk : in bit);
  end;

architecture filter_arch of filter_generic is
	signal historia0 : signed (15 downto 0) := to_signed(0,16);
	signal historia1 : signed (15 downto 0) := to_signed(0,16);
	
begin
	filter_proc: process(clk)
		variable sum1 : signed (31 downto 0);
		variable sum2 : signed (31 downto 0);
		variable mult : signed (31 downto 0);

	begin
		if (clk'event and clk = '1') then
			sum1 := b0*sin - a1*historia0 - a2*historia1;
			sum2 := sum1 + b1*historia0 + b2*historia1;
			historia1 <= historia0;
			historia0 <= sum1(25 downto 10);
			mult := gs*sum2(25 downto 10);
			sout <= mult(25 downto 10);
		end if;
	end process;
end filter_arch;
