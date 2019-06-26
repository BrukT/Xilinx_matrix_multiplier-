library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Adder_8b is
	port(
		a: in std_logic_vector( 7 downto 0);
		b: in std_logic_vector( 7 downto 0);
		c: out std_logic_vector( 7 downto 0)
	);
end Adder_8b;

architecture behv of Adder_8b is 
begin 
	c <= a + b;
end behv;