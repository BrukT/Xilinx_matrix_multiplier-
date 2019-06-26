library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------------
-- this is a wrapper entity to wrap the matrix multiplier to 2 by 3 and 3 by 4 inputs 
-- and 2 by 4 output
-------------------------------------------------------------------------------------

entity Mat_Mul_wrapper is
port(
	--matrixes are represented in vector with raw major order
	--2 * 3 matrix A inputs
	-- raw 1 -----------------------------
	A11: in std_logic_vector( 3 downto 0);
	A12: in std_logic_vector( 3 downto 0);
	A13: in std_logic_vector( 3 downto 0);
	--------------------------------------
	-- raw 2 -----------------------------
	A21: in std_logic_vector( 3 downto 0);
	A22: in std_logic_vector( 3 downto 0);
	A23: in std_logic_vector( 3 downto 0);

	
	--------------------------------------
	--3 * 4 matrix B inputs
	-- raw 1 -----------------------------
	B11: in std_logic_vector( 3 downto 0);
	B12: in std_logic_vector( 3 downto 0);
	B13: in std_logic_vector( 3 downto 0);
	B14: in std_logic_vector( 3 downto 0);

	B21: in std_logic_vector( 3 downto 0);
	B22: in std_logic_vector( 3 downto 0);
	B23: in std_logic_vector( 3 downto 0);
	B24: in std_logic_vector( 3 downto 0);

	B31: in std_logic_vector( 3 downto 0);
	B32: in std_logic_vector( 3 downto 0);
	B33: in std_logic_vector( 3 downto 0);
	B34: in std_logic_vector( 3 downto 0);

	--2*4 matrix C outputs
	C11: out std_logic_vector( 7 downto 0); -- raw 1 col 1
	C12: out std_logic_vector( 7 downto 0); -- raw 1 col 2
	C13: out std_logic_vector( 7 downto 0);
	C14: out std_logic_vector( 7 downto 0);

	C21: out std_logic_vector( 7 downto 0);
	C22: out std_logic_vector( 7 downto 0);
	C23: out std_logic_vector( 7 downto 0);
	C24: out std_logic_vector( 7 downto 0)
);
end Mat_Mul_Wrapper;

architecture str of Mat_Mul_Wrapper is

component Mat_Mul is
generic (N, M, P: integer);
port(
	--matrixes are represented in vector with raw major order
	--2 * 3 matrix A inputs
	-- raw 1 -----------------------------
	A11: in std_logic_vector( 3 downto 0);
	A12: in std_logic_vector( 3 downto 0);
	A13: in std_logic_vector( 3 downto 0);
	--------------------------------------
	-- raw 2 -----------------------------
	A21: in std_logic_vector( 3 downto 0);
	A22: in std_logic_vector( 3 downto 0);
	A23: in std_logic_vector( 3 downto 0);

	
	--------------------------------------
	--3 * 4 matrix B inputs
	-- raw 1 -----------------------------
	B11: in std_logic_vector( 3 downto 0);
	B12: in std_logic_vector( 3 downto 0);
	B13: in std_logic_vector( 3 downto 0);
	B14: in std_logic_vector( 3 downto 0);

	B21: in std_logic_vector( 3 downto 0);
	B22: in std_logic_vector( 3 downto 0);
	B23: in std_logic_vector( 3 downto 0);
	B24: in std_logic_vector( 3 downto 0);

	B31: in std_logic_vector( 3 downto 0);
	B32: in std_logic_vector( 3 downto 0);
	B33: in std_logic_vector( 3 downto 0);
	B34: in std_logic_vector( 3 downto 0);

	--2*4 matrix C outputs
	C11: out std_logic_vector( 7 downto 0); -- raw 1 col 1
	C12: out std_logic_vector( 7 downto 0); -- raw 1 col 2
	C13: out std_logic_vector( 7 downto 0);
	C14: out std_logic_vector( 7 downto 0);

	C21: out std_logic_vector( 7 downto 0);
	C22: out std_logic_vector( 7 downto 0);
	C23: out std_logic_vector( 7 downto 0);
	C24: out std_logic_vector( 7 downto 0)
);
end component Mat_Mul;
begin

------------------------------------------------------------------------------
--- here set up the inputs and also set up the zize parameters for the matrix
------------------------------------------------------------------------------

MatMul: Mat_Mul
		generic map( N => 2, M => 3, P => 4)
		port map( A11 => A11, A12 => A12, A13 => A13,
			  A21 => A21, A22 => A22, A23 => A23,
			  B11 => B11, B12 => B12, B13 => B13, B14 => B14,
			  B21 => B21, B22 => B22, B23 => B23, B24 => B24,
			  B31 => B31, B32 => B32, B33 => B33, B34 => B34,
			  C11 => C11, C12 => C12, C13 => C13, C14 => C14,
			  C21 => C21, C22 => C22, C23 => C23, C24 => C24);
end str;