
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity Mult_Booth_PO is

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

end entity;

architecture rtl of Mult_Booth_PO is

signal md_reg				:	unsigned ((LP_PO-1) downto 0);
signal count_reg			:	unsigned (2 downto 0);
signal mr_reg, R_reg		:	unsigned ((LP_PO*2-1) downto 0);
signal sel_operacao 		:  unsigned (2 downto 0);
signal operacao_parcial	:	unsigned ((LP_PO*2-1) downto 0);

begin

	process(clk_PO) is
	variable aux_operacao : unsigned ((LP_PO*2-1) downto 0);
	begin
		if(rising_edge(clk_PO)) then
			if(init_PO = '1') then
				md_reg 		 		<= MD_PO;
				mr_reg 		 		<= (11|10|9|8|7 => '0') & MR_PO & (0 => '0');
				count_reg 	 		<= (others => '0');
				sel_operacao 		<= (others => '0');
				operacao_parcial	<= (others => '0');
				R_reg 		 		<= (others => '0');
			else
				-- Coleta 3 bits menos significativos de MR
				sel_operacao <= mr_reg(2 downto 0);
				-- Deslocamento de 2 bits para a direita de MR
				mr_reg <= mr_reg srl 2;
				-- Adicionei um ao count_reg = vou fazer a n operação
				count_reg <= count_reg + 1;
				-- Mux para selecionar a operação
				if(sel_operacao = "000") then
					aux_operacao := (others => '0');
				elsif(sel_operacao = "001") then
					aux_operacao := (11|10|9|8|7|6 => '0') & md_reg;
				elsif(sel_operacao = "010") then
					aux_operacao := (11|10|9|8|7|6 => '0') & md_reg;
				elsif(sel_operacao = "011") then
					aux_operacao := (11|10|9|8|7|6 => '0') & md_reg sll 1; -- multiplicação por 2
				elsif(sel_operacao = "100") then
					aux_operacao := (11|10|9|8|7|6 => '0') & not md_reg; -- complemento de 2
					aux_operacao := aux_operacao + 1; -- complemento de 2
					aux_operacao := aux_operacao sll 1; -- multiplicação por 2
					aux_operacao := (11|10|9|8|7 => '1') & aux_operacao(6 downto 0); -- extensão do sinal
				elsif(sel_operacao = "101") then -- extensão do sinal
					aux_operacao := (11|10|9|8|7|6 => '0') & not md_reg; -- complemento de 2
					aux_operacao := aux_operacao + 1;	-- complemento de 2
					aux_operacao := (11|10|9|8|7 => '1') & aux_operacao(6 downto 0); 
				elsif(sel_operacao = "000") then -- extensão do sinal
					aux_operacao := (11|10|9|8|7|6 => '0') & not md_reg; -- complemento de 2
					aux_operacao := aux_operacao + 1; -- complemento de 2
					aux_operacao := (11|10|9|8|7 => '1') & aux_operacao(6 downto 0); -- extensão do sinal
				else
					aux_operacao := (others => '0');
				end if;
				-- Fim do mux da operação
				-- Mux para verificar o deslocamento
				if(count_reg = "010") then
					operacao_parcial <=  aux_operacao sll 2;
				elsif(count_reg = "011") then
					operacao_parcial <=  aux_operacao sll 4;
				else
					operacao_parcial <= aux_operacao;
				end if;
				-- Fim do mux para efetuar o deslocamento
				-- Somador
				if(enr_PO = '1') then
					R_reg 	<= R_reg + operacao_parcial;
				end if;
				-- Fim do somador
			end if;
		end if;
	end process;

	count_PO <= count_reg;
	R_PO 		<= R_reg;
	
end rtl;
