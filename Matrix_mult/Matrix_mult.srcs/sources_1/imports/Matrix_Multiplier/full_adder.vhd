library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder is   -- entity declaration
       --generic(N_bit : integer);  -- generic parameter modelling the generic number of bits of the shift register
	   port(
			a       : in std_logic;   --  Shift register input
			b       : in std_logic;   --  Shift register output
			cin     : in std_logic;   --  clk                
			s 	: out std_logic;
			cout    : out std_logic  --  Asynchronous active low reset
	       );
end full_adder;

architecture bhv of full_adder is  -- architectural declaration (behavioral description)

begin
	cout <= (a and b) or (b and cin) or (a and cin);

	s <= a xor (b xor cin);

end bhv;
