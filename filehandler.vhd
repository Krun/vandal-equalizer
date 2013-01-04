library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--http://www.depeca.uah.es/depeca/repositorio/asignaturas/30791/T4_06_simulacion_avanzada.pdf
entity arch3 is
end entity arch3;
architecture comport of arch3 is
type cfile is file of character;
file f1i: cfile open read_mode is"f11.txt" ;
file f1o: cfile open write_mode is "f21.txt" ;
begin
process
variable char:character;
begin
while not endfile(f1i) loop
read (f1i,char);
write (f1o,char);
wait for 50 ns;
end loop;

-- cierre de archivos
file_close(f1i);
file_close(f1o);
wait;
end process;
end comport;
