--
-- Copyright 1991-2012 Mentor Graphics Corporation
--
-- All Rights Reserved.
--
-- THIS WORK CONTAINS TRADE SECRET AND PROPRIETARY INFORMATION WHICH IS THE PROPERTY OF 
-- MENTOR GRAPHICS CORPORATION OR ITS LICENSORS AND IS SUBJECT TO LICENSE TERMS.
--   

entity counter is
	port (count : buffer bit_vector(8 downto 1);
		clk   : in bit;
		reset : in bit);
end;

architecture only of counter is
	constant tpd_reset_to_count : time := 3 ns;
	constant tpd_clk_to_count   : time := 2 ns;

	function increment(val : bit_vector) return bit_vector
	is
		-- normalize the indexing
		alias input : bit_vector(val'length downto 1) is val;
		variable result : bit_vector(input'range) := input;
		variable carry : bit := '1';
	begin
		for i in input'low to input'high loop
			result(i) := input(i) xor carry;
			carry := input(i) and carry;
			exit when carry = '0';
		end loop;
		return result;
	end increment;
begin

	ctr:
	process(clk, reset)
	begin
		if (reset = '1') then
			if reset'event then
				count <= (others => '0') after tpd_reset_to_count;
			end if;
		elsif clk'event and (clk = '1') then
			count <= increment(count) after tpd_clk_to_count;
		end if;
	end process;

end only;


