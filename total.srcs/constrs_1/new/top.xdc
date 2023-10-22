set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN H16 [get_ports clk]
create_clock -period 8.000 -name sys_clk_pin -waveform {0.000 4.000} -add [get_ports clk]

set_property PACKAGE_PIN D19 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {adc_data[0]}]
set_property PACKAGE_PIN T14 [get_ports {adc_data[7]}]  
set_property PACKAGE_PIN U12 [get_ports {adc_data[6]}]
set_property PACKAGE_PIN U13 [get_ports {adc_data[5]}]
set_property PACKAGE_PIN V13 [get_ports {adc_data[4]}]
set_property PACKAGE_PIN V15 [get_ports {adc_data[3]}]
set_property PACKAGE_PIN T15 [get_ports {adc_data[2]}]
set_property PACKAGE_PIN R16 [get_ports {adc_data[1]}]
set_property PACKAGE_PIN U17 [get_ports {adc_data[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports {ad_clk}]
set_property PACKAGE_PIN V17 [get_ports {ad_clk}]   

set_property IOSTANDARD LVCMOS33 [get_ports {but}]
set_property PACKAGE_PIN M20 [get_ports {but}]

set_property IOSTANDARD LVCMOS33 [get_ports {sel[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {sel[3]}]

set_property PACKAGE_PIN V18 [get_ports {sel[0]}]   
set_property PACKAGE_PIN T16 [get_ports {sel[1]}]
set_property PACKAGE_PIN R17 [get_ports {sel[2]}]
set_property PACKAGE_PIN P18 [get_ports {sel[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]
set_property PACKAGE_PIN N17 [get_ports {seg[0]}]   
set_property PACKAGE_PIN Y13 [get_ports {seg[1]}]   
set_property PACKAGE_PIN Y11 [get_ports {seg[2]}]   
set_property PACKAGE_PIN Y12 [get_ports {seg[3]}]
set_property PACKAGE_PIN W11 [get_ports {seg[4]}]
set_property PACKAGE_PIN V11 [get_ports {seg[5]}]
set_property PACKAGE_PIN T5 [get_ports {seg[6]}]
set_property PACKAGE_PIN U10 [get_ports {seg[7]}]
