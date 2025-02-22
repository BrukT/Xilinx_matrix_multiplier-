library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- it is the main part of the project				    ----	
-- An N by M and M by P matrix multiplier			    ----
-- the inputs are fixed because port decalaration can't be generic  ----
-- the sizes of the matrices are generic integers 	            ---- 
------------------------------------------------------------------------ 
entity Mat_Mul is
	generic (N, M, P : integer);
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
end Mat_Mul;
	
---------------------------------------------------------------------
-- Structural Architecture of the matrix multiplier          --------
-- has multiplier and rippleCarry Adder Components inside    --------
-- it gives out the result matirix multiplied number         --------
---------------------------------------------------------------------
architecture str of Mat_Mul is
------------------------------------------------------------------------------------------
--- created the matirix types to do the iterative generation of multiplier and adder circuits
------------------------------------------------------------------------------------------
type a_matrix is array( 0 to N - 1, 0 to M - 1) of std_logic_vector(3 downto 0);
type b_matrix is array( 0 to M - 1, 0 to P - 1) of std_logic_vector(3 downto 0);
type c_matrix is array( 0 to N - 1, 0 to P - 1) of std_logic_vector(7 downto 0);

-------------------------------------------------------------------------------------------
--- Instantiate new matrices based on the type specified above
-------------------------------------------------------------------------------------------

signal A : a_matrix;
signal B : b_matrix;
signal C : c_matrix;

------------------------------------------------------------------------------------------
--- Define the interconnections as a matrix type
------------------------------------------------------------------------------------------
--- interconnections to take products of two matrix elements
--- the number of products are n * m * p
type product is array(0 to N - 1,0 to P - 1, 0 to M - 1) of std_logic_vector(7 downto 0);

--- interconnections to take sum of products
--- the number of sums are n * p * (m - 1)
type sum is array(0 to (N - 1), 0 to P - 1,0 to M - 2) of std_logic_vector(7 downto 0);

--- instantiate the connections
signal int_prod: product;
signal int_sum: sum;

component Mul_4b is

	port(
		a: in std_logic_vector(3 downto 0);
		b: in std_logic_vector(3 downto 0);
		c: out std_logic_vector(7 downto 0)
	);
end component Mul_4b;

component rippleCarry 
port(
		a : in std_logic_vector(7 downto 0);
		b : in std_logic_vector(7 downto 0);
		c_in : in std_logic;
		o : out std_logic_vector(7 downto 0);
		c_o : out std_logic
	);
end component rippleCarry;

begin
--- input to internal signal mapping of elements
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
	
------------------------------------------------------------------------------------------------------------------
--- Iteratively generate the elements and connect them with the above instantiated connections
------------------------------------------------------------------------------------------------------------------
	GEN_I: for i in  0 to N - 1  generate
		GEN_II: for j in 0 to P - 1 generate
			------------------------------------------------------------------------
			---- Separately generate the product connections for each matrix
			---------------------------------------------------------------------
			GEN_III: for n in 0 to M - 1 generate
				MUL:Mul_4b port map(A(i,n), B(n,j), int_prod(i, j, n)); 
			end generate GEN_III;
			--------------------------------------------------------------------------------
			--- take the product outputs generated above and add them in a sequential manner
			---------------------------------------------------------------------------------
			SUM: for k in 0 to M - 2 generate
				---------------------------------------------------------------------------------
				--- special attention in the first one because only the sum of products are added
				----------------------------------------------------------------------------------
				FIRST: if k = 0 generate
					ADDF:rippleCarry port map(int_prod(i, j, k), int_prod(i ,j , k + 1), '0', int_sum(i, j, k), open);
				end generate FIRST;
				---------------------------------------------------------------------------------
				--- Here the sum (of privious products) and new product is added
				--------------------------------------------------------------------------------- 
				INTERNAL: if k > 0 and k < M - 2 generate
					ADDI:rippleCarry port map(int_sum(i, j, k - 1), int_prod(i, j, k + 1), '0', int_sum(i, j, k), open);
				end generate INTERNAL;
				---------------------------------------------------------------------------------
				--- here the sum result is given to the result matix element
				---------------------------------------------------------------------------------
				LAST: if k = M - 2 generate
					ADDL:rippleCarry port map(int_sum(i , j, k - 1), int_prod(i, j, k + 1), '0', C(i,j), open);
				end generate LAST;
			end generate SUM;
		end generate GEN_II;
	end generate GEN_I;
	
end str;