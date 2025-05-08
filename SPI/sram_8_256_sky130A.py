# Cấu hình cơ bản
tech_name = "sky130A"
word_size = 8
num_words = 256
output_path = "SPI"
output_name = "sram_{0}_{1}_{2}".format(word_size, num_words, tech_name)

# Bắt buộc để bật output .mag (layout cho Magic)
output_extensions = ["gds", "lef", "sp", "lib", "v", "html", "mag"]