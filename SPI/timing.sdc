# Tên clock chính (10ns = 100MHz)
create_clock -name clk -period 10.0 [get_ports clk]

# Ràng buộc input delay đối với các tín hiệu đầu vào
set_input_delay -max 2.0 -clock clk [get_ports MOSI]
set_input_delay -max 2.0 -clock clk [get_ports ss_n]
set_input_delay -max 2.0 -clock clk [get_ports rst_n]

# Ràng buộc output delay đối với tín hiệu MISO
set_output_delay -max 2.0 -clock clk [get_ports MISO]

# Nếu cần, có thể khai báo thêm clock groups để tránh báo timing ảo
set_clock_groups -asynchronous -group {clk} -group { }

# (Tùy chọn) Đặt false path cho các tín hiệu không quan trọng
# Ví dụ: reset bất đồng bộ
set_false_path -from [get_ports rst_n]

