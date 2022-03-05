library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Mult_Booth_Top is 

	generic(
		LP_TOP : natural :=  6
	);

	port(
		clk_TOP		: in std_logic;
		rst_TOP		: in std_logic;
		MD_TOP		: in unsigned((LP_TOP-1) downto 0);
		MR_TOP	: in unsigned((LP_TOP -1) downto 0);
		R_TOP			: out unsigned((LP_TOP*2-1) downto 0) 
	);
	
end entity;


architecture rtl of Mult_Booth_Top is

component Mult_Booth_PO is

	generic(
		LP_PO	:	natural :=6
	);
	
	port(
		clk_PO	:	in std_logic;
		init_PO	:	in std_logic;
		enR_PO	:	in std_logic;
		MD_PO		:	in unsigned((LP_PO-1) downto 0);	
		MR_PO		:	in unsigned((LP_PO-1) downto 0);
		count_PO	:	out unsigned (2 downto 0);
		R_PO		:	out unsigned((LP_PO*2-1) downto 0)
	);
	
end component;

component Mult_Booth_PC is

	port(
		clk_PC		:	in std_logic;
		rst_PC		:	in std_logic;
		count_PC		:	in unsigned (2 downto 0);
		init_PC	   :	out std_logic;
		enR_PC		:	out std_logic		
	);
	
end component;

signal count_conn : unsigned (2 downto 0);
signal init_conn, enR_conn: std_logic;

begin

PO : Mult_Booth_PO 
				 port map(
					clk_PO	=>	clk_TOP, 
					init_PO	=> init_conn,
					enR_PO	=> enR_conn,
					MD_PO		=> MD_TOP,	
					MR_PO		=> MR_TOP,
					count_PO	=> count_conn,
					R_PO		=> R_TOP
				 );

PC : Mult_Booth_PC 
				 port map(
				 clk_PC		=> clk_TOP,
				 rst_PC		=> rst_TOP,
				 count_PC	=> count_conn,
				 init_PC	   => init_conn,
				 enR_PC		=> enR_conn
				 );

end rtl;