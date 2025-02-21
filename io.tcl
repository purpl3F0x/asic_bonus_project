# Top pin (clk_i)
set_io_pin_constraint -region top:* -pin_names {clk_i}

# Left side pins (valid_i, coeff_i, data_i, coeff_addr_i)
set_io_pin_constraint -region left:* -pin_names {valid_i}
set_io_pin_constraint -region left:* -pin_names {coeff_i}
set_io_pin_constraint -region left:* -pin_names {data_i[*]}
set_io_pin_constraint -region left:* -pin_names {coeff_addr_i[*]}

# Right side pins (data_o, coeff_data_io)
set_io_pin_constraint -region right:* -pin_names {data_o[*]}
set_io_pin_constraint -region right:* -pin_names {coeff_data_io[*]}
