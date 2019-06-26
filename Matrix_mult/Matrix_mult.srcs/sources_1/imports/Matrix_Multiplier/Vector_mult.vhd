library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vector_mult is
	port(
		A1: in std_logic_vector(3 downto 0);
		A2: in std_logic_vector(3 downto 0);
		A3: in std_logic_vector(3 downto 0);
		B1: in std_logic_vector(3 downto 0);
		B2: in std_logic_vector(3 downto 0);
		B3: in std_logic_vector(3 downto 0);
		C: out std_logic_vector(7 downto 0)
	);
end vector_mult;

architecture behv of vector_mult is 
signal s1: std_logic_vector(7 downto 0);

type vector is array(0 to 2) of std_logic_vector(3 downto 0);
type signal_vec is array(0 to 2) of std_logic_vector(7 downto 0);
signal A_vec: vector;
signal B_vec: vector;
signal M: signal_vec;


component rippleCarry 
port(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c_in : in std_logic;
		o : out std_logic_vector(7 downto 0);
		c_o : out std_logic
	);
end component rippleCarry;

component Multi_4b 
port(	
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		c: out std_logic_vector(7 downto 0)
	);
end component Multi_4b;

begin
A_vec(0) <= A1; 
A_vec(1) <= A2; 
A_vec(2) <= A3; 
B_vec(0) <= B1; 
B_vec(1) <= B2; 
B_vec(2) <= B3;

	GEN_M: for i in 0 to 2 generate
		MUL: Multi_4b port map (A_vec(i), B_vec(i), M(i));
	end generate GEN_M;
	GEN_A: rippleCarry port map(M(0), M(1), '0', s1, open);
	GEN_A2: rippleCarry port map(s1, M(2), '0', C, open);
end behv;
