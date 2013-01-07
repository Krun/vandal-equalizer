-- Filtro genérico con mejoras añadidas

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity filter_generic_m is
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

architecture filter_arch_mod of filter_generic_m is

	COMPONENT multiplier_16x16b
	port (
    sigA : in signed (15 downto 0);
    sigB : in signed (15 downto 0);
    mult : out signed (31 downto 0)
  );
  END COMPONENT;
  
  COMPONENT adder_16b
  port (
    sig1 : in signed (15 downto 0);
    sig2 : in signed (15 downto 0);
    cin : in std_logic;
    cout : out std_logic;
    sum : out signed (15 downto 0)
  );
  END COMPONENT;
 	
 	signal historia0 : signed (15 downto 0) := to_signed(0,16);
	signal historia1 : signed (15 downto 0) := to_signed(0,16);
  
  signal a1neg : signed(15 downto 0) := to_signed(-a1,16);
  signal a2neg : signed(15 downto 0) := to_signed(-a2,16);
  signal b0sig : signed(15 downto 0) := to_signed(b0,16);
  signal b1sig : signed(15 downto 0) := to_signed(b1,16);
  signal b2sig : signed(15 downto 0) := to_signed(b2,16);
  signal gssig : signed(15 downto 0) := to_signed(gs,16);
  
  signal gsin : signed (15 downto 0) := to_signed(0,16);
  
  signal prod0 : signed(31 downto 0); -- b0*sin
  signal prod1 : signed(31 downto 0); -- (-a1)*historia0
  signal prod2 : signed(31 downto 0); -- (-a2)*historia1
  signal prod3 : signed(31 downto 0); -- b1*historia0
  signal prod4 : signed(31 downto 0); -- b2*historia1
    
  signal suma0 : signed(15 downto 0); -- prod0 + prod1
  signal suma1 : signed(15 downto 0); -- suma0 + prod2  <-- Esto va a la historia0
  signal suma2 : signed(15 downto 0); -- suma1 + prod3
  signal suma3 : signed(15 downto 0); -- suma2 + prod4
  
  signal prodsin : signed(31 downto 0); -- gs*sin
begin
  
  --aplicamos primero la ganancia final para evitar saturación en puntos intermedios
  mult_s : multiplier_16x16b
  PORT MAP(
    sigA => gssig,
    sigB => sin,
    mult => prodsin
  );
  
  gsin <= prodsin(25 downto 10);
  
  mult0 : multiplier_16x16b
  PORT MAP(
    sigA => b0sig,
    sigB => gsin,
    mult => prod0
  );
  mult1 : multiplier_16x16b
  PORT MAP(
    sigA => a1neg,
    sigB => historia0,
    mult => prod1
  );
  mult2 : multiplier_16x16b
  PORT MAP(
    sigA => a2neg,
    sigB => historia1,
    mult => prod2
  );
  mult3 : multiplier_16x16b
  PORT MAP(
    sigA => b1sig,
    sigB => historia0,
    mult => prod3
  );
  mult4 : multiplier_16x16b
  PORT MAP(
    sigA => b2sig,
    sigB => historia1,
    mult => prod4
  );
  

  
  add0 : adder_16b
  PORT MAP(
    sig1 => prod0(25 downto 10),
    sig2 => prod1(25 downto 10),
    cin => '0',
    cout => open,
    sum => suma0
  );
  
  add1 : adder_16b
  PORT MAP(
    sig1 => suma0,
    sig2 => prod2(25 downto 10),
    cin => '0',
    cout => open,
    sum => suma1
  );
  
  add2 : adder_16b
  PORT MAP(
    sig1 => suma1,
    sig2 => prod3(25 downto 10),
    cin => '0',
    cout => open,
    sum => suma2
  );
  add3 : adder_16b
  PORT MAP(
    sig1 => suma2,
    sig2 => prod4(25 downto 10),
    cin => '0',
    cout => open,
    sum => suma3
  );
	filter_proc: process(clk)
		variable sum1 : signed (15 downto 0);
		variable sum2 : signed (15 downto 0);
		variable mult : signed (31 downto 0);

	begin
		if (clk'event and clk = '1') then
			--sout <= prod5(25 downto 10);
			sout <= suma3;
			historia1 <= historia0;
			historia0 <= suma1;
		end if;
	end process;
end filter_arch_mod;
