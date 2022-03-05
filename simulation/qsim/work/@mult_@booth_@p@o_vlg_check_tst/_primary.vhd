library verilog;
use verilog.vl_types.all;
entity Mult_Booth_PO_vlg_check_tst is
    port(
        count_PO        : in     vl_logic_vector(2 downto 0);
        R_PO            : in     vl_logic_vector(11 downto 0);
        sampler_rx      : in     vl_logic
    );
end Mult_Booth_PO_vlg_check_tst;
