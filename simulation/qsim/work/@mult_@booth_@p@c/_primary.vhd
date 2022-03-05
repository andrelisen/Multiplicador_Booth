library verilog;
use verilog.vl_types.all;
entity Mult_Booth_PC is
    port(
        clk_PC          : in     vl_logic;
        rst_PC          : in     vl_logic;
        count_PC        : in     vl_logic_vector(5 downto 0);
        init_PC         : out    vl_logic;
        enR_PC          : out    vl_logic
    );
end Mult_Booth_PC;
