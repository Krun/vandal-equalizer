library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
     		iout0 : out integer;
            iout1 : out integer;
            iout2 : out integer;
            iout3 : out integer;
            iout4 : out integer;
            iout5 : out integer;
            iout6 : out integer);
end;

architecture only of test_filter is

signal sout0 : std_logic_vector (15 downto 0);
signal sout1 : std_logic_vector (15 downto 0);
signal sout2 : std_logic_vector (15 downto 0);
signal sout3 : std_logic_vector (15 downto 0);
signal sout4 : std_logic_vector (15 downto 0);
signal sout5 : std_logic_vector (15 downto 0);
signal sout6 : std_logic_vector (15 downto 0);

signal out0 : signed (15 downto 0);
signal out1 : signed (15 downto 0);
signal out2 : signed (15 downto 0);
signal out3 : signed (15 downto 0);
signal out4 : signed (15 downto 0);
signal out5 : signed (15 downto 0);
signal out6 : signed (15 downto 0);

COMPONENT filter0
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter1
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter2
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

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

COMPONENT filter5
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

COMPONENT filter6
	port (
		sin : in std_logic_vector (15 downto 0);
		sout : out std_logic_vector (15 downto 0);
		clk : in bit);
END COMPONENT ;

SIGNAL clk   : bit := '0';
SIGNAL sin  : std_logic_vector (15 downto 0) := "0000000000000000";

begin
out0 <= signed(sout0);
out1 <= signed(sout1);
out2 <= signed(sout2);
out3 <= signed(sout3);
out4 <= signed(sout4);
out5 <= signed(sout5);
out6 <= signed(sout6);

iout0 <= to_integer(out0);
iout1 <= to_integer(out1);
iout2 <= to_integer(out2);
iout3 <= to_integer(out3);
iout4 <= to_integer(out4);
iout5 <= to_integer(out5);
iout6 <= to_integer(out6);

dut0 : filter0 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout0);

dut1 : filter1 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout1);

dut2 : filter2 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout2);

dut3 : filter3 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout3);
   
dut4 : filter4
   PORT MAP (
     sin => sin,
     clk => clk,
     sout => sout4);

dut5 : filter5
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout5);

dut6 : filter6 
   PORT MAP (
   sin => sin,
   clk => clk,
   sout => sout6);

clock : PROCESS
   begin
   wait for 10 ns; clk  <= not clk;
end PROCESS clock;

stimulus : PROCESS
   begin
   sin <= "0000000000000000";
   wait for 5 ns; sin  <= "0000010000000000";
   wait for 10 ns; sin  <= "0000000000000000";
   wait;
end PROCESS stimulus;

end only;

