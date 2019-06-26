library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Multi_4b is
	port(
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		c: out std_logic_vector(7 downto 0)
	);
end Multi_4b;

architecture behv of Multi_4b is
begin
	c <= std_logic_vector(signed(a) * signed(b));
end behv;
