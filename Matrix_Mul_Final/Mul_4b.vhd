library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

----------------------------------------------------------------------
--- a twos complement multiplier to be part of the marix multiplier --
----------------------------------------------------------------------

entity Mul_4b is
	port(
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		c: out std_logic_vector(7 downto 0)
	);
end Mul_4b;


architecture behv of Mul_4b is
begin
	-------------------------------------------------------------------------------
	-- a trik used here is to change the value intepretation to signed ones
	-- because the multiplicatoin operation is similar in signed or unsigned. 
	-- so we type cast the inputs form std_logic_vector to unsigned     
	-------------------------------------------------------------------------------
	c <= std_logic_vector(signed(a) * signed(b));
end behv;
