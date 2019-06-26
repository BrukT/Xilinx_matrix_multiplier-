library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-----------------------------------------------------------------------------
--- This is a testbench to check the appropriate working of the muliplier ---
-----------------------------------------------------------------------------

entity MatMul_tb is

end MatMul_tb;

architecture tb of MatMul_tb is

-------------------------------------------------------------------------
--- signal type creation and instatiation
-------------------------------------------------------------------------

type twoByThree is array(0 to 1, 0 to 2) of std_logic_vector( 3 downto 0);
type threeByFour is array(0 to 2, 0 to 3) of std_logic_vector( 3 downto 0); 
type twoByFour is array(0 to 1, 0 to 3) of std_logic_vector(7 downto 0);
signal Atb: twoByThree;
signal Btb: threeByFour;
signal Ctb: twoByFour;

--------------------------------------------------------------------------
--- Include the matrix multiplier component
--------------------------------------------------------------------------

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
	MatMul: Mat_Mul
		---* Here specify the sizes of the matrixes to be given to the matrix multiplier.*----
		generic map( N => 2, M => 3, P => 4)
		---* Here do the input output mappings of the signals with the matrix multiplier.*----
		port map( A11 => Atb(0,0), A12 => Atb(0,1), A13 => Atb(0,2),
			  A21 => Atb(1,0), A22 => Atb(1,1), A23 => Atb(1,2),
			  B11 => Btb(0,0), B12 => Btb(0,1), B13 => Btb(0,2), B14 => Btb(0,3),
			  B21 => Btb(1,0), B22 => Btb(1,1), B23 => Btb(1,2), B24 => Btb(1,3),
			  B31 => Btb(2,0), B32 => Btb(2,1), B33 => Btb(2,2), B34 => Btb(2,3),
			  C11 => Ctb(0,0), C12 => Ctb(0,1), C13 => Ctb(0,2), C14 => Ctb(0,3),
			  C21 => Ctb(1,0), C22 => Ctb(1,1), C23 => Ctb(1,2), C24 => Ctb(1,3));
	process 
		--- Include the possible tes cases for multiplication check ---
	begin
		---- Varying element value multiplication ----
		Atb <= ((x"3",x"3",x"3"),(x"1",x"1",x"1"));
		Btb <= ((x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"));
		wait for 100 ns;
		---- Similar in a matix but different with the other matix element multiplication ---
		Atb <= ((x"3",x"3",x"3"),(x"3",x"3",x"3"));
		Btb <= ((x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"));
		wait for 200 ns;
		---- Negative number containing matrix as an input to the multiplier -----------
		Atb <= ((x"f",x"f",x"1"),(x"1",x"1",x"1"));
		Btb <= ((x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"));
		wait for 100 ns;
		---- equal value for all the elements in the matrixes --------------------------
		Atb <= ((x"2",x"2",x"2"),(x"2",x"2",x"2"));
		Btb <= ((x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"),(x"2",x"2",x"2",x"2"));
		wait for 100 ns;
	end process;
end tb;