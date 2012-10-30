library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_signed.all;

--
-- Copyright 1991-2012 Mentor Graphics Corporation
--
-- All Rights Reserved.
--
-- THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
-- MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
--   

entity test_filter is
    PORT (
     		sout3 : out std_logic_vector (15 downto 0);
     		sout4 : out std_logic_vector (15 downto 0));
end;

architecture only of test_filter is

COMPONENT filter3
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter4
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

SIGNAL clk   : bit := '0';
SIGNAL sin  : std_logic_vector (15 downto 0) := "0000000000000000";

begin


dut : filter3 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout3);
   
dutt : filter4
   PORT MAP (
     sin => sin,
     clk => clk,
     sout => sout4);

clock : PROCESS
   begin
   wait for 10 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   sin <= "0000000000000000";
   wait for 5 ns; sin  <= "0000010000000000";
   wait for 9 ns; sin  <= "0000000000000000";
   wait;
end PROCESS stimulus;

end only;

