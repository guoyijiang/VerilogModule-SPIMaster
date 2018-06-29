library verilog;
use verilog.vl_types.all;
entity SPIMaster is
    generic(
        HBDIV           : integer := 1;
        BITS            : integer := 16;
        CSDN            : integer := 1;
        CSUN            : integer := 1;
        SCKINT          : vl_logic := Hi1;
        SPEDGE          : vl_logic := Hi0
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        start           : in     vl_logic;
        dataOut         : in     vl_logic_vector;
        dataIn          : out    vl_logic_vector;
        working         : out    vl_logic;
        sck             : out    vl_logic;
        sdo             : out    vl_logic;
        cs              : out    vl_logic;
        sdi             : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of HBDIV : constant is 1;
    attribute mti_svvh_generic_type of BITS : constant is 1;
    attribute mti_svvh_generic_type of CSDN : constant is 1;
    attribute mti_svvh_generic_type of CSUN : constant is 1;
    attribute mti_svvh_generic_type of SCKINT : constant is 1;
    attribute mti_svvh_generic_type of SPEDGE : constant is 1;
end SPIMaster;
