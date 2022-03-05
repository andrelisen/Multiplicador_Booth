entity testbench1 is end;

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

architecture tb_multiplicador of testbench1 is
    component Mult_Booth_Top is 

        generic(
            LP_TOP : natural :=  6
        );
    
        port(
            clk_TOP		: in std_logic;
            rst_TOP		: in std_logic;
            MD_TOP		: in unsigned((LP_TOP-1) downto 0);
            MR_TOP		: in unsigned((LP_TOP -1) downto 0);
            R_TOP		: out unsigned((LP_TOP*2-1) downto 0) 
        );
        
    end component;

    signal clk_tb   :   std_logic := '0';
    signal rst_tb   :   std_logic := '0';
    signal MD_tb    :   unsigned(5 downto 0) := "010101";
    signal MR_tb    :   unsigned(5 downto 0) := "011110";
    signal R_tb     :   unsigned(11 downto 0);

begin

    tb_Mult_TOP : Mult_Booth_Top port map(
        clk_TOP		=> clk_tb,
        rst_TOP		=> rst_tb,
        MD_TOP		=> MD_tb,
        MR_TOP		=> MR_tb,
        R_TOP		=> R_tb
    );
    
   clk_tb <= not clk_tb after 5 ns; -- geração do clock
   process
   begin
    rst_tb <= '1';
    wait for 20 ns;
      rst_tb <= '0';
      wait;
   end process;

end tb_multiplicador;