
(*use_dsp ="yes"*)

module fir #(
    parameter DATA_IN_WIDTH = 16,
    parameter TAPS = 15,
    parameter TAPS_WIDTH = 16,
    parameter DATA_OUT_WIDTH = 32,
    parameter TAPS_ADDR_WIDTH = ($clog2(TAPS + 1))
) (
    input wire clk_i,

    // Control Signals
    input wire rst_i,
    input wire valid_i,
    input wire coeff_i,

    // Data Inputs
    input wire signed [DATA_IN_WIDTH-1:0] data_i,
    input wire [TAPS_ADDR_WIDTH-1:0] coeff_addr_i,
    inout [TAPS_WIDTH-1:0] coeff_data_io,  // Outputs the (coeff_addr)'n tap, when coeff_i=0

    // Data Outputs
    output reg signed [DATA_OUT_WIDTH-1:0] data_o
);

  reg signed [DATA_OUT_WIDTH-1:0] mac_accum[TAPS-1:0];
  reg signed [DATA_OUT_WIDTH-1:0] mult_pipe[TAPS-1:0];
  reg signed [TAPS_WIDTH-1:0] taps[TAPS-1:0];

  reg signed [TAPS_WIDTH-1:0] tap_buff;

  integer i;

  initial begin
    taps[0]  = 6;
    taps[1]  = 9;
    taps[2]  = 3;
    taps[3]  = -11;
    taps[4]  = -15;
    taps[5]  = 4;
    taps[6]  = 37;
    taps[7]  = 53;
    taps[8]  = 37;
    taps[9]  = 4;
    taps[10] = -15;
    taps[11] = -11;
    taps[12] = -3;
    taps[13] = 9;
    taps[14] = 6;
  end

  always @(posedge clk_i) begin
    if (rst_i == 1) begin
      for (i = 0; i < TAPS; i = i + 1) begin
        mac_accum[i] <= 0;
        mult_pipe[i] <= 0;
      end

    end
    else begin
      // Process Coeffs write
      if (coeff_i == 1) begin
        taps[coeff_addr_i] <= coeff_data_io;
      end
      else begin
        tap_buff <= taps[coeff_addr_i];
      end

      // Process Data
      if (valid_i == 1) begin
        for (i = 0; i < TAPS; i = i + 1) begin
          if (i != TAPS - 1) begin
            mult_pipe[i] <= data_i * taps[i];
            mac_accum[i] <= mult_pipe[i] + mac_accum[i+1];
          end
          else begin
            mult_pipe[i] <= data_i * taps[i];
            mac_accum[i] <= mult_pipe[i];
          end
        end
      end
    end
    data_o <= mac_accum[0];
  end

  assign coeff_data_io = (coeff_i == 0) ? tap_buff : 'dz;
endmodule

