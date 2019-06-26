library IEEE;
use IEEE.std_logic_1164.all;

------------------------------------------------------------
---- an adder to add 8 bit numbers -------------------------
------------------------------------------------------------
entity rippleCarry is
	port(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c_in : in std_logic;
		o : out std_logic_vector(7 downto 0);
		c_o : out std_logic
	);
end rippleCarry;

------------------------------------------------------------
--- use full adder components in thre rtl architecture -----
------------------------------------------------------------

Architecture rtl of rippleCarry is

component full_adder
		port(
			a       : in std_logic;   --  Shift register input
			b       : in std_logic;   --  Shift register output
			cin     : in std_logic;   --  clk
	              	s 	: out std_logic;
			cout    : out std_logic  --  Asynchronous active low reset
		);
end component full_adder;

signal c_internal : std_logic_vector( 6 downto 0);

begin
----------------------------------------------------------------------------
---- give the appropriate inputs to each full adder
----------------------------------------------------------------------------
GEN: for i in 0 to 7 generate
	FIRST: if i = 0 generate
		FA1: full_adder port map(a(i), b(i), c_in, o(i), c_internal(i));
		end generate FIRST;
 
	INTERNAL: if i > 0 and i < 7 generate
		FAI: full_adder port map(a(i), b(i), c_internal(i-1), o(i), c_internal(i));
		end generate INTERNAL;

	LAST: if i = 7 generate
		FAN: full_adder port map(a(i), b(i), c_internal(i-1), o(i), c_o);
		end generate LAST;
end generate GEN;
end rtl;