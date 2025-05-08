#Read modules from verilog
read_verilog spi_to_sram_wrapper.v
read_verilog sram_8_256_sky130A_blackbox.v
read_verilog SPI_SLAVE.v
#Elaborate design hierarchy
hierarchy -check -top spi_to_sram_wrapper

#Translate Processes to netlist
proc

#mapping to the internal cell library
techmap

#mapping flip-flops to lib
dfflibmap -liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib
opt


#mapping logic to lib
abc -liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib


#remove unused cells
clean

#write the synthesized design in a verilog file
stat -liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130_fd_sc_hd__tt_025C_1v80.lib

write_verilog -noattr SPI_synth.v

