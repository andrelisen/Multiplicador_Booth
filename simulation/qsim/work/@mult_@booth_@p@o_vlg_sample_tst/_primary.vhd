library verilog;
use verilog.vl_types.all;
entity Mult_Booth_PO_vlg_sample_tst is
    port(
        clk_PO          : in     vl_logic;
        enR_PO          : in     vl_logic;
        init_PO         : in     vl_logic;
        MD_PO           : in     vl_logic_vector(5 downto 0);
        MR_PO           : in     vl_logic_vector(5 downto 0);
        sampler_tx      : out    vl_logic
    );
end Mult_Booth_PO_vlg_sample_tst;
