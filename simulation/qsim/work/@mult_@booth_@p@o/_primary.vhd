library verilog;
use verilog.vl_types.all;
entity Mult_Booth_PO is
    port(
        clk_PO          : in     vl_logic;
        init_PO         : in     vl_logic;
        enR_PO          : in     vl_logic;
        MD_PO           : in     vl_logic_vector(5 downto 0);
        MR_PO           : in     vl_logic_vector(5 downto 0);
        count_PO        : out    vl_logic_vector(2 downto 0);
        R_PO            : out    vl_logic_vector(11 downto 0)
    );
end Mult_Booth_PO;
