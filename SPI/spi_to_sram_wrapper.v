module spi_to_sram_wrapper (
    input clk, rst_n, ss_n,
    input MOSI,
    output MISO,

    // SRAM power pins if needed
`ifdef USE_POWER_PINS
    inout vdd,
    inout gnd,
`endif
    // SPI-SRAM bridge
    output [7:0] debug_addr,
    output [7:0] debug_din,
    output [7:0] debug_dout
);

    // SPI Slave wires
    wire [9:0] rx_data;
    wire rx_valid, tx_valid;
    wire [7:0] tx_data;
    reg  [7:0] sram_din;
    reg  [7:0] sram_addr;
    reg        sram_write_en;

    // SRAM wires
    reg  csb0 = 1;
    reg  web0 = 1;
    wire [7:0] dout0;

    // Instantiate SPI_SLAVE
    SPI_SLAVE spi (
        .MOSI(MOSI), .MISO(MISO),
        .tx_valid(tx_valid), .tx_data(tx_data),
        .rx_valid(rx_valid), .rx_data(rx_data),
        .clk(clk), .rst_n(rst_n), .ss_n(ss_n)
    );

    // Instantiate SRAM
    sram_8_256_sky130A sram (
`ifdef USE_POWER_PINS
        .vdd(vdd), .gnd(gnd),
`endif
        .clk0(clk),
        .csb0(csb0),
        .web0(web0),
        .addr0(sram_addr),
        .din0(sram_din),
        .dout0(dout0)
    );

    // Bridge logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            csb0 <= 1;
            web0 <= 1;
        end else begin
            if (rx_valid) begin
                case (rx_data[9:8])
                    2'b00: begin // WRITE
                        csb0 <= 0;
                        web0 <= 0;
                        sram_addr <= rx_data[7:0];
                        sram_din <= rx_data[7:0]; // Có thể cần tách địa chỉ và data riêng
                    end
                    2'b01: begin // READ
                        csb0 <= 0;
                        web0 <= 1;
                        sram_addr <= rx_data[7:0];
                    end
                    default: begin
                        csb0 <= 1;
                        web0 <= 1;
                    end
                endcase
            end
        end
    end

    assign tx_data = dout0;
    assign debug_addr = sram_addr;
    assign debug_din = sram_din;
    assign debug_dout = dout0;

endmodule
