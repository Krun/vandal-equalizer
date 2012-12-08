--
-- Copyright 1991-2012 Mentor Graphics Corporation
--
-- All Rights Reserved.
--
-- THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
-- MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
--   

entity test_counter is
    PORT ( count : BUFFER bit_vector(8 downto 1));
end;

architecture only of test_counter is

COMPONENT counter
      PORT ( count : BUFFER bit_vector(8 downto 1);
             clk   : IN bit;
             reset : IN bit);
END COMPONENT ;

SIGNAL clk   : bit := '0';
SIGNAL reset : bit := '0';

begin

dut : counter 
   PORT MAP (
   count => count,
   clk => clk,
   reset => reset );

clock : PROCESS
   begin
   wait for 10 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   wait for 5 ns; reset  <= '1';
   wait for 4 ns; reset  <= '0';
   wait;
end PROCESS stimulus;

end only;

