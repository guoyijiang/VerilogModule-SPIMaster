#Clock signal
create_clock -period 10.000 -name crystal_clk_pin -add [get_ports crystal_clk];
create_clock -period 10.000 -name sys_clk_pin -add [get_ports clk];

# Clock Pin, 100MHz input
set_property PACKAGE_PIN N11 [get_ports crystal_clk];
set_property IOSTANDARD LVCMOS33 [get_ports crystal_clk];
set_property PACKAGE_PIN F4  [get_ports clk];
set_property IOSTANDARD LVCMOS33 [get_ports clk];

#SI5351 PINs
set_property PACKAGE_PIN C2  [get_ports si5351_sda];
set_property PACKAGE_PIN C3  [get_ports si5351_scl];
set_property IOSTANDARD LVCMOS33 [get_ports si5351_*];

# DDR3 Pins, See ll7a35ek_ddr3.xdc which is used by mig tools, not here

# Flash Pins
#set_property PACKAGE_PIN J13 [get_ports spi_flash_io0_io];
#set_property PACKAGE_PIN J14 [get_ports spi_flash_io1_io];
#set_property PACKAGE_PIN K15 [get_ports spi_flash_io2_io];     # uncomment this line if using spix4 mode
#set_property PACKAGE_PIN K16 [get_ports spi_flash_io3_io];     # uncomment this line if using spix4 mode
#set_property PACKAGE_PIN L12 [get_ports spi_flash_ss_io[0]];
#set_property IOSTANDARD LVCMOS33 [get_ports {spi_flash_*}];

# Keys' Pin
#set_property PACKAGE_PIN N2  [get_ports key[0]];    # PCB Designator "K2"
#set_property PACKAGE_PIN R3  [get_ports key[1]];    # PCB Designator "K3"
#set_property PACKAGE_PIN T2  [get_ports key[2]];    # PCB Designator "K4"
#set_property PACKAGE_PIN R2  [get_ports key[3]];    # PCB Designator "K5"
#set_property PACKAGE_PIN R1  [get_ports key[4]];    # PCB Designator "K6"
#set_property PACKAGE_PIN P1  [get_ports key[5]];    # PCB Designator "K7"
#set_property PACKAGE_PIN T4  [get_ports key[6]];    # PCB Designator "K8"
#set_property PACKAGE_PIN T3  [get_ports key[7]];    # PCB Designator "K9"
#set_property IOSTANDARD LVCMOS33 [get_ports {key[*]}];

# LEDs' Pin
set_property PACKAGE_PIN P5  [get_ports led[0]];
set_property PACKAGE_PIN L5  [get_ports led[1]];
set_property PACKAGE_PIN N4  [get_ports led[2]];
set_property PACKAGE_PIN P4  [get_ports led[3]];
set_property PACKAGE_PIN M4  [get_ports led[4]];
set_property PACKAGE_PIN L4  [get_ports led[5]];
set_property PACKAGE_PIN P3  [get_ports led[6]];
set_property PACKAGE_PIN N3  [get_ports led[7]];
set_property IOSTANDARD LVCMOS33 [get_ports {led[*]}];

# XADC's Vp & Vn, not use(tied ground)
#set_property PACKAGE_PIN H8 [get_ports Vp_Vn_v_p];
#set_property PACKAGE_PIN J7 [get_ports Vp_Vn_v_n];
#set_property IOSTANDARD LVCMOS33 [get_ports {Vp_Vn_v_*}];

# LCD pins
#set_property PACKAGE_PIN M2 [get_ports lcd_scl];
#set_property PACKAGE_PIN N1 [get_ports lcd_sda];
#set_property PACKAGE_PIN M1 [get_ports lcd_rstn];
#set_property IOSTANDARD LVCMOS33 [get_ports {lcd_*}];

#AD9288 IOs
set_property PACKAGE_PIN D1  [get_ports ad9288_a[7]];  # n
set_property PACKAGE_PIN E2  [get_ports ad9288_a[6]];  # p
set_property PACKAGE_PIN E1  [get_ports ad9288_a[5]];  # n
set_property PACKAGE_PIN F2  [get_ports ad9288_a[4]];  # p
set_property PACKAGE_PIN G1  [get_ports ad9288_a[3]];  # n
set_property PACKAGE_PIN G2  [get_ports ad9288_a[2]];  # p
set_property PACKAGE_PIN H1  [get_ports ad9288_a[1]];  # n
set_property PACKAGE_PIN H2  [get_ports ad9288_a[0]];  # p
set_property PACKAGE_PIN L3  [get_ports ad9288_b[0]];  # p
set_property PACKAGE_PIN L2  [get_ports ad9288_b[1]];  # n
set_property PACKAGE_PIN K3  [get_ports ad9288_b[2]];  # p
set_property PACKAGE_PIN K2  [get_ports ad9288_b[3]];  # n
set_property PACKAGE_PIN K1  [get_ports ad9288_b[4]];  # p
set_property PACKAGE_PIN J1  [get_ports ad9288_b[5]];  # n
set_property PACKAGE_PIN J3  [get_ports ad9288_b[6]];  # p
set_property PACKAGE_PIN H3  [get_ports ad9288_b[7]];  # n
set_property IOSTANDARD LVCMOS33 [get_ports ad9288_*];

#DAC5652A IOs
set_property PACKAGE_PIN R5  [get_ports dac5652a_a[0]];  # p
set_property PACKAGE_PIN T5  [get_ports dac5652a_a[1]];  # n
set_property PACKAGE_PIN T7  [get_ports dac5652a_a[2]];  # p
set_property PACKAGE_PIN T8  [get_ports dac5652a_a[3]];  # n
set_property PACKAGE_PIN T9  [get_ports dac5652a_a[4]];  # p
set_property PACKAGE_PIN T10 [get_ports dac5652a_a[5]];  # n
set_property PACKAGE_PIN R12 [get_ports dac5652a_a[6]];  # p
set_property PACKAGE_PIN T12 [get_ports dac5652a_a[7]];  # n
set_property PACKAGE_PIN R13 [get_ports dac5652a_a[8]];  # p
set_property PACKAGE_PIN T13 [get_ports dac5652a_a[9]];  # n
set_property PACKAGE_PIN R11 [get_ports dac5652a_b[0]];  # n
set_property PACKAGE_PIN R10 [get_ports dac5652a_b[1]];  # p
set_property PACKAGE_PIN P9  [get_ports dac5652a_b[2]];  # n
set_property PACKAGE_PIN N9  [get_ports dac5652a_b[3]];  # p
set_property PACKAGE_PIN R8  [get_ports dac5652a_b[4]];  # n
set_property PACKAGE_PIN P8  [get_ports dac5652a_b[5]];  # p
set_property PACKAGE_PIN R7  [get_ports dac5652a_b[6]];  # n
set_property PACKAGE_PIN R6  [get_ports dac5652a_b[7]];  # p
set_property PACKAGE_PIN N6  [get_ports dac5652a_b[8]];  # n
set_property PACKAGE_PIN M6  [get_ports dac5652a_b[9]];  # p
set_property IOSTANDARD LVCMOS33 [get_ports dac5652a_*];

#PMODE0
#set_property PACKAGE_PIN D3  [get_ports pm000];  # n
#set_property PACKAGE_PIN E3  [get_ports pm001];  # p
#set_property PACKAGE_PIN C6  [get_ports pm006];  # n
#set_property PACKAGE_PIN C7  [get_ports pm007];  # p

set_property PACKAGE_PIN C4  [get_ports SCK_ADS8860];  # n
set_property PACKAGE_PIN D4  [get_ports DI_ADS8860];  # p
set_property PACKAGE_PIN D5  [get_ports CS_ADS8860];  # n
#set_property PACKAGE_PIN D6  [get_ports pm005];  # p
#set_property IOSTANDARD LVCMOS33 [get_ports pm0*];

#PMODE3
#set_property PACKAGE_PIN L14 [get_ports pm300];  # p
#set_property PACKAGE_PIN M14 [get_ports pm301];  # n
#set_property PACKAGE_PIN P10 [get_ports pm306];  # p
#set_property PACKAGE_PIN P11 [get_ports pm307];  # n

#set_property PACKAGE_PIN N13 [get_ports pm302];  # p
#set_property PACKAGE_PIN P13 [get_ports pm303];  # n
#set_property PACKAGE_PIN N14 [get_ports pm304];  # p
#set_property PACKAGE_PIN P14 [get_ports pm305];  # n
#set_property IOSTANDARD LVCMOS33 [get_ports pm3*];

# P3
#set_property PACKAGE_PIN B7  [get_ports p300];  # p
#set_property PACKAGE_PIN A7  [get_ports p301];  # n
#set_property PACKAGE_PIN B6  [get_ports p302];  # p
##set_property PACKAGE_PIN B5  [get_ports p303];  # n
#set_property PACKAGE_PIN A5  [get_ports p304];  # p
#set_property PACKAGE_PIN A4  [get_ports p305];  # n
#set_property PACKAGE_PIN B4  [get_ports p306];  # p
set_property PACKAGE_PIN A3  [get_ports CS_ADS7883A];  # n
set_property PACKAGE_PIN B2  [get_ports DI_ADS7883A];  # p
set_property PACKAGE_PIN A2  [get_ports SCK_ADS7883A];  # n
set_property PACKAGE_PIN B1  [get_ports CS_ADS7883B];  # n
set_property PACKAGE_PIN C1  [get_ports DI_ADS7883B];  # p
set_property PACKAGE_PIN F3  [get_ports SCK_ADS7883B];  # n
#set_property IOSTANDARD LVCMOS33 [get_ports p3*];

#P4
#set_property PACKAGE_PIN L13 [get_ports p400];  # n
set_property PACKAGE_PIN K13 [get_ports CS_DAC8811];  # p
set_property PACKAGE_PIN M16 [get_ports DO_DAC8811];  # p
set_property PACKAGE_PIN N16 [get_ports SCK_DAC8811];  # n
#set_property PACKAGE_PIN P15 [get_ports p404];  # p
#set_property PACKAGE_PIN P16 [get_ports p405];  # n
#set_property PACKAGE_PIN R15 [get_ports CS];  # p
#set_property PACKAGE_PIN R16 [get_ports SCK];  # n
#set_property PACKAGE_PIN T14 [get_ports MISO];  # p
#set_property PACKAGE_PIN T15 [get_ports MOSI];  # n

# IO Bank 14 default 3.3V.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 14]];

# IO Bank 34 default 3.3V.
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 34]];

# IO Bank 35 default 3.3V. You may change this when unloading JP1 and powering VCCO35 by VIOA pin of PA 
set_property IOSTANDARD LVCMOS33 [get_ports -of_objects [get_iobanks 35]];