library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--http://www.depeca.uah.es/depeca/repositorio/asignaturas/30791/T4_06_simulacion_avanzada.pdf


entity filehandler is
  port(
 	  sink : in signed (15 downto 0);
	  source : out signed (15 downto 0);
	  clk : in bit
	  );
end entity filehandler;
architecture comport of filehandler is
type cfile is file of signed;
file f1i: cfile open read_mode is "f11.txt" ;
file f1o: cfile open write_mode is "f21.txt" ;
begin
process
variable wrd:std_logic_vector(15 downto 0);
begin
while not endfile(f1i) loop
read (f1i,wrd);
write (f1o,wrd);
wait for 50 ns;
end loop;

-- cierre de archivos
file_close(f1i);
file_close(f1o);
wait;
end process;
end comport;
