library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Matrix_Multi is
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
end Matrix_Multi;
	
architecture str of Matrix_Multi is
--- created the matirix
type a_matrix is array( 0 to 1, 0 to 2) of std_logic_vector(3 downto 0);
type b_matrix is array( 0 to 2, 0 to 3) of std_logic_vector(3 downto 0);
type c_matrix is array( 0 to 1, 0 to 3) of std_logic_vector(7 downto 0);
---
signal A : a_matrix;
signal B : b_matrix;
signal C : c_matrix;

signal tmp: std_logic_vector(7 downto 0);

component vector_mult is
	port(
		A1: in std_logic_vector(3 downto 0);
		A2: in std_logic_vector(3 downto 0);
		A3: in std_logic_vector(3 downto 0);
		B1: in std_logic_vector(3 downto 0);
		B2: in std_logic_vector(3 downto 0);
		B3: in std_logic_vector(3 downto 0);
		C: out std_logic_vector(7 downto 0)
	);
end component vector_mult;
begin
	A(0,0) <= a11;
	A(0,1) <= a12;
	A(0,2) <= a13;
	A(1,0) <= a21;
	A(1,1) <= a22;
	A(1,2) <= a23;

	B(0,0) <= b11;
	B(0,1) <= b12;
	B(0,2) <= b13;
	B(0,3) <= b14;
	B(1,0) <= b21;
	B(1,1) <= b22;
	B(1,2) <= b23;
	B(1,3) <= b24;
	B(2,0) <= b31;
	B(2,1) <= b32;
	B(2,2) <= b33;
	B(2,3) <= b34;
	
	C11 <= C(0,0);
	C12 <= C(0,1);
	C13 <= C(0,2);
	C14 <= C(0,3);
	C21 <= C(1,0);
	C22 <= C(1,1);
	C23 <= C(1,2);
	C24 <= C(1,3);
	

	GEN_I: for i in  0 to 1 generate
		GEN_II: for j in 0 to 3 generate
			Mult_vec: Vector_mult port map(A(i,0), A(i,1), A(i,2), B(0,j), B(1,j), B(2,j), C(i,j));
		end generate GEN_II;
	end generate GEN_I;
	
end str;