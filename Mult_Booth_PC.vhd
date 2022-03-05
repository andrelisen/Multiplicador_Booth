
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity Mult_Booth_PC is

	port(
		clk_PC		:	in std_logic;
		rst_PC		:	in std_logic;
		count_PC		:	in unsigned (2 downto 0);
		init_PC	   :	out std_logic;
		enR_PC		:	out std_logic		
	);

end entity;

architecture rtl of Mult_Booth_PC is 

-- cria um tipo estado
type state_type is (s0, s1, s2, s3);

-- cria um sinal do tipo state
signal state : state_type;
--limite do contador
constant limit : unsigned(2 downto 0) := "101"; -- 101 = 5

begin

	-- atualizar o estado
	process(clk_PC)
	begin
		if (rising_edge(clk_PC)) then
			if (rst_PC = '1') then
				state <= s0;
			else
				case state is 
					when s0 =>
							state <= s1;
					when s1 =>
						if(count_PC = "000") then
							state <= s1;
						else
							state <= s2;
						end if;
					when s2 =>
						if(count_PC < limit) then
							state <= s2;
						else
							state <= s3;
						end if;
					when s3 =>
						state <= s3;
				end case;
			end if;
		end if;
	end process;
	
	-- atualização das saidas do controle
	process(state)
	begin
		case state is 
			when s0 => 
				init_PC <= '1';
				enR_PC <= '0';
			when s1 =>
				init_PC <= '0';
				enR_PC <= '0';
			when s2 =>
				init_PC <= '0';
				enR_PC <= '1';
			when s3 =>
				init_PC <= '0';
				enR_PC <= '0';
		end case;
	end process;
	
end rtl;