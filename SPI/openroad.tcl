set script_dir [file dirname [info script]]
set test_dir "/home/tuan/Desktop/OpenROAD/test"

# Load helper scripts
source "$test_dir/helpers.tcl"
source "$test_dir/flow_helpers.tcl"
source "$test_dir/sky130hd/sky130hd.vars"

read_lef /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130hd.tlef
read_lef /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130hd_std_cell.lef

read_liberty /home/tuan/Desktop/OpenROAD/test/sky130hd/sky130hd_tt.lib
read_liberty sram_8_256_sky130A_TT_1p8V_25C.lib
# Load LEF
read_lef sram_8_256_sky130A.lef

# read netlist
set design "SPI_WRAPPER"
read_verilog SPI_synth.v
link_design spi_to_sram_wrapper
read_sdc timing.sdc

# Set physical design constraints
set die_area {0 0 940 940}
set core_area {80 80 860 860}

# Place SRAM macro


# Power distribution network (PDN)


# Load flow script
source -echo "floorplan.tcl"


