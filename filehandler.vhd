--
-- Gestor de ficheros
-- Modulo auxiliar para leer y escribir señales
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.txt_util.all;
--http://www.depeca.uah.es/depeca/repositorio/asignaturas/30791/T4_06_simulacion_avanzada.pdf
--http://www.stefanvhdl.com/vhdl/html/file_read.html


entity filehandler is
  generic(
    stim_file: string := "stimulus.dat";
    log_file: string := "output.dat"
    );
  port(
 	  sink : in signed (15 downto 0);
	  source : out signed (15 downto 0);
	  clk : in bit;
	  RST  : in  std_logic;
    EOG  : out std_logic
	  );
end entity filehandler;


architecture comport of filehandler is
  file stimulus: TEXT open read_mode is stim_file;
  file l_file: TEXT open write_mode is log_file;
  
  signal Y : std_logic_vector(15 downto 0) := "0000000000000000";
  begin
  source <= signed(Y);

  read_data: process
  variable l: line;
  variable s: string(16 downto 1);
  begin
     EOG <= '0';
     -- wait for Reset to complete
     wait until RST='1';
     wait until RST='0';
     while not endfile(stimulus) loop
  
       -- read digital data from input file
       readline(stimulus, l);
       read(l, s);
       Y <= to_std_logic_vector(s);
       
       wait until CLK = '1';
     end loop;
     EOG <= '1';
     wait;
   end process read_data;
   
   
  receive_data: process
    variable l: line;
    begin                                       
       -- print header for the logfile
       --print(l_file, "#  x1   x2 ");
       --print(l_file, "#----------");
       --print(l_file, " ");
       --wait until RST='1';
       --wait until RST='0';

       while true loop
    
         -- write digital data into log file
         --* write(l, str(x1)& " "& hstr(x2)& "h");
         --* writeline(l_file, l);
         print(l_file, str(std_logic_vector(sink)));
    
         wait until CLK = '1';
        
       end loop;

 end process receive_data;
end comport;
