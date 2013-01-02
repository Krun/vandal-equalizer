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
	 
	signal prod0 : signed(31 downto 0); -- b0*sin
  signal prod1 : signed(31 downto 0); -- (-a1)*historia0
  signal prod2 : signed(31 downto 0); -- (-a2)*historia1
  signal prod3 : signed(31 downto 0); -- b1*historia0
  signal prod4 : signed(31 downto 0); -- b2*historia1
    
  signal suma0 : signed(15 downto 0); -- prod0 + prod1
  signal suma1 : signed(15 downto 0); -- suma0 + prod2  <-- Esto va a la historia0
  signal suma2 : signed(15 downto 0); -- suma1 + prod3
  signal suma3 : signed(15 downto 0); -- suma2 + prod4
  
  signal prod5 : signed(31 downto 0); -- gs*suma3
begin
  prod0 <= b0*sin;
  prod1 <= (-a1)*historia0;
  prod2 <= (-a2)*historia1;
  prod3 <= b1*historia0;
  prod4 <= b2*historia1;
  
  suma0 <= prod0(25 downto 10)+prod1(25 downto 10);
  suma1 <= suma0+prod2(25 downto 10);
  suma2 <= suma1+prod3(25 downto 10);
  suma3 <= suma2+prod4(25 downto 10);
  
  prod5 <= gs*suma3;
  
	filter_proc: process(clk)
	begin
		if (clk'event and clk = '1') then
			sout <= prod5(25 downto 10);
			historia1 <= historia0;
			historia0 <= suma1;
		end if;
	end process;
end filter_arch;
