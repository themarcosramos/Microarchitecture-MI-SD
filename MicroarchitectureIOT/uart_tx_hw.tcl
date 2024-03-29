# TCL File Generated by Component Editor 13.0sp1
# Sun Jul 28 21:20:48 BRT 2019
# DO NOT MODIFY


# 
# uart_tx "uart_tx" v1.0
#  2019.07.28.21:20:48
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module uart_tx
# 
set_module_property DESCRIPTION ""
set_module_property NAME uart_tx
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME uart_tx
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL uart_tx
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file uart_tx.v VERILOG PATH Uart_tx_rx/uart_tx.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter CLKS_PER_BIT INTEGER 434
set_parameter_property CLKS_PER_BIT DEFAULT_VALUE 434
set_parameter_property CLKS_PER_BIT DISPLAY_NAME CLKS_PER_BIT
set_parameter_property CLKS_PER_BIT TYPE INTEGER
set_parameter_property CLKS_PER_BIT UNITS None
set_parameter_property CLKS_PER_BIT ALLOWED_RANGES -2147483648:2147483647
set_parameter_property CLKS_PER_BIT HDL_PARAMETER true


# 
# display items
# 


# 
# connection point nios_custom_instruction_slave
# 
add_interface nios_custom_instruction_slave nios_custom_instruction end
set_interface_property nios_custom_instruction_slave clockCycle 0
set_interface_property nios_custom_instruction_slave operands 2
set_interface_property nios_custom_instruction_slave ENABLED true
set_interface_property nios_custom_instruction_slave EXPORT_OF ""
set_interface_property nios_custom_instruction_slave PORT_NAME_MAP ""
set_interface_property nios_custom_instruction_slave SVD_ADDRESS_GROUP ""

add_interface_port nios_custom_instruction_slave i_Tx_DV dataa Input 1
add_interface_port nios_custom_instruction_slave i_Tx_Byte datab Input 8
add_interface_port nios_custom_instruction_slave o_Tx_Active result Output 1
add_interface_port nios_custom_instruction_slave o_Tx_Done done Output 1
add_interface_port nios_custom_instruction_slave i_Clock clk Input 1


# 
# connection point conduit_end
# 
add_interface conduit_end conduit end
set_interface_property conduit_end associatedClock ""
set_interface_property conduit_end associatedReset ""
set_interface_property conduit_end ENABLED true
set_interface_property conduit_end EXPORT_OF ""
set_interface_property conduit_end PORT_NAME_MAP ""
set_interface_property conduit_end SVD_ADDRESS_GROUP ""

add_interface_port conduit_end o_Tx_Serial o_tx_serial Output 1

