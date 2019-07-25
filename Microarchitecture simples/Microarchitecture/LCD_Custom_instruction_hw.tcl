# TCL File Generated by Component Editor 13.0sp1
# Tue Jun 25 15:23:52 BRT 2019
# DO NOT MODIFY


# 
# LCD_Custom_instruction "LCD_Custom_instruction" v1.0
#  2019.06.25.15:23:52
# 
# 

# 
# request TCL package from ACDS 13.1
# 
package require -exact qsys 13.1


# 
# module LCD_Custom_instruction
# 
set_module_property DESCRIPTION ""
set_module_property NAME LCD_Custom_instruction
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME LCD_Custom_instruction
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL AUTO
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL init_lcd
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
add_fileset_file init_lcd.v VERILOG PATH init_lcd.v TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter idle_state STD_LOGIC_VECTOR 0
set_parameter_property idle_state DEFAULT_VALUE 0
set_parameter_property idle_state DISPLAY_NAME idle_state
set_parameter_property idle_state TYPE STD_LOGIC_VECTOR
set_parameter_property idle_state ENABLED false
set_parameter_property idle_state UNITS None
set_parameter_property idle_state ALLOWED_RANGES 0:7
set_parameter_property idle_state HDL_PARAMETER true
add_parameter busy_state STD_LOGIC_VECTOR 1
set_parameter_property busy_state DEFAULT_VALUE 1
set_parameter_property busy_state DISPLAY_NAME busy_state
set_parameter_property busy_state TYPE STD_LOGIC_VECTOR
set_parameter_property busy_state ENABLED false
set_parameter_property busy_state UNITS None
set_parameter_property busy_state ALLOWED_RANGES 0:7
set_parameter_property busy_state HDL_PARAMETER true
add_parameter end_state STD_LOGIC_VECTOR 3
set_parameter_property end_state DEFAULT_VALUE 3
set_parameter_property end_state DISPLAY_NAME end_state
set_parameter_property end_state TYPE STD_LOGIC_VECTOR
set_parameter_property end_state ENABLED false
set_parameter_property end_state UNITS None
set_parameter_property end_state ALLOWED_RANGES 0:7
set_parameter_property end_state HDL_PARAMETER true


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

add_interface_port nios_custom_instruction_slave dataB datab Input 32
add_interface_port nios_custom_instruction_slave result result Output 32
add_interface_port nios_custom_instruction_slave clk_en clk_en Input 1
add_interface_port nios_custom_instruction_slave start start Input 1
add_interface_port nios_custom_instruction_slave done done Output 1
add_interface_port nios_custom_instruction_slave dataA dataa Input 32
add_interface_port nios_custom_instruction_slave clk clk Input 1
add_interface_port nios_custom_instruction_slave reset reset Input 1


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

add_interface_port conduit_end read_write read_write Output 1
add_interface_port conduit_end register_select register_select Output 1
add_interface_port conduit_end enable_op enable_op Output 1
add_interface_port conduit_end data_out data_out Output 8

