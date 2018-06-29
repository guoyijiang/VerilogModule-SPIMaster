library verilog;
use verilog.vl_types.all;
entity DACx811 is
    generic(
        HBDIV           : integer := 1;
        BITS            : integer := 16
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        data            : in     vl_logic_vector;
        busy            : out    vl_logic;
        sck             : out    vl_logic;
        sdo             : out    vl_logic;
        cs_n            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of HBDIV : constant is 1;
    attribute mti_svvh_generic_type of BITS : constant is 1;
end DACx811;
