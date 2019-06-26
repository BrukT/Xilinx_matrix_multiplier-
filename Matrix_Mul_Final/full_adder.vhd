library IEEE;
use IEEE.std_logic_1164.all;

------------------------------------------------
-- a full adder to do binary addtion of two bits
------------------------------------------------
entity full_adder is   
      	   port(
			a       : in std_logic;   --  first input
			b       : in std_logic;   --  first output
			cin     : in std_logic;   --  carry input                 
			s 	: out std_logic;  --  sum output
			cout    : out std_logic   --  carry output
	       );
end full_adder;

----------------------------------------
-- behavioural architectural description
----------------------------------------
architecture data_flow of full_adder is  

begin
	cout <= (a and b) or (b and cin) or (a and cin);

	s <= a xor (b xor cin);

end data_flow;
