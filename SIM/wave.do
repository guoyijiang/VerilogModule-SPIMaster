onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/clk
add wave -noupdate /testbench/rst
add wave -noupdate /testbench/SPIMaster_A/start
add wave -noupdate /testbench/SPIMaster_A/working
add wave -noupdate /testbench/SPIMaster_A/csd_co
add wave -noupdate /testbench/SPIMaster_A/csu_co
add wave -noupdate -radix unsigned /testbench/SPIMaster_A/csdCnt/cnt
add wave -noupdate -radix unsigned /testbench/SPIMaster_A/csuCnt/cnt
add wave -noupdate -radix unsigned /testbench/SPIMaster_A/stateSPI
add wave -noupdate /testbench/SPIMaster_A/busy
add wave -noupdate /testbench/delay
add wave -noupdate /testbench/SPIMaster_A/hbr_co
add wave -noupdate /testbench/SPIMaster_A/hbc_co
add wave -noupdate -radix unsigned /testbench/SPIMaster_A/hbc_cnt
add wave -noupdate /testbench/SPIMaster_A/shifterOut
add wave -noupdate /testbench/SPIMaster_A/shifterIn
add wave -noupdate /testbench/CS_A
add wave -noupdate /testbench/SPIMaster_A/sEn
add wave -noupdate /testbench/SCK_A
add wave -noupdate /testbench/SDO_A
add wave -noupdate /testbench/SDI_A
add wave -noupdate -radix hexadecimal /testbench/dataOut_A
add wave -noupdate -radix hexadecimal /testbench/dataIn_A
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix unsigned /testbench/SPIMaster_B/hbc_cnt
add wave -noupdate /testbench/SPIMaster_B/shifterOut
add wave -noupdate /testbench/SPIMaster_B/shifterIn
add wave -noupdate /testbench/CS_B
add wave -noupdate /testbench/SCK_B
add wave -noupdate /testbench/SDO_B
add wave -noupdate /testbench/SDI_B
add wave -noupdate -radix hexadecimal /testbench/dataOut_B
add wave -noupdate -radix hexadecimal /testbench/dataIn_B
add wave -noupdate -divider {New Divider}
add wave -noupdate /testbench/data_da
add wave -noupdate -radix unsigned /testbench/dac8811_inst/hbc_cnt
add wave -noupdate /testbench/sck_da
add wave -noupdate /testbench/sdo_da
add wave -noupdate /testbench/cs_da
add wave -noupdate /testbench/dac8811_inst/shifter
add wave -noupdate /testbench/dac8811_inst/hbr_co
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 5} {318 ns} 0} {{Cursor 6} {4459 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1000
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4387 ns} {4593 ns}
