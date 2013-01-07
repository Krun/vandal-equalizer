--Modulo de retardo
--Retarda la señal de entrada un numero configurable de posiciones

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity delay is
generic (
    size: integer := 256
);
port (
    clk : in bit;
    dataout : out signed(15 downto 0);
    datain : in signed(15 downto 0)
         );
end delay;

architecture arch_delay of delay is
type memory_type is array (0 to size) of signed(15 downto 0);
signal memory : memory_type :=(others => (others => '0'));   --cola inicializada a cero
signal pointer: integer := 0; --posicion de lectura/escritura

begin
    process(clk)
    begin
    if(clk'event and clk='1') then
        dataout <= memory(pointer); -- primero sacamos la posicion
        memory(pointer) <= datain; -- y la sobreescribimos para la siguiente vuelta
        pointer <= pointer + 1;
    end if;
    if(pointer = size) then
        pointer <= 0;
    end if;
    end process;

end arch_delay;
