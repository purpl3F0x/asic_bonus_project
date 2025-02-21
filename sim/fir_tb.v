`timescale 1ns / 1ps

module FIR_Filter_tb ();

  reg signed [15:0] data_in;
  reg [3:0] coeff_addr;
  wire [15:0] coeff_data;
  reg [15:0] coeff_data_reg;
  reg clk, rst, valid_in, coeff_in;
  wire signed [31:0] data_out;

  real i;

  localparam real pi = 3.141592653589793115997963468544185161590576171875;


  fir uut (
      .clk_i(clk),
      .rst_i(rst),
      .valid_i(valid_in),
      .data_i(data_in),
      .data_o(data_out),
      .coeff_addr_i(coeff_addr),
      .coeff_i(coeff_in),
      .coeff_data_io(coeff_data)

  );

  assign coeff_data = (coeff_in == 1) ? coeff_data_reg : 'dz;


  initial begin
    clk = 1'b0;
    #2.5;
    forever begin
      #(2.5) clk = ~clk;
    end
  end

  initial begin
    $dumpfile("fir_tb.vcd");
    $dumpvars();

    rst = 0;
    valid_in = 0;
    data_in = 0;
    coeff_in = 0;
    coeff_addr = 0;
    coeff_data_reg = 0;

    #(100)
    // Reset    
    rst = 1'b1;
    @(posedge clk);
    @(posedge clk);

    rst = 1'b0;
    data_in = 1;
    valid_in = 1'b1;


    repeat (42000) begin
      @(posedge clk) data_in = $rtoi(30000.0 * $sin(pi * (i / 200))) + ($random % 2500);
      i = i + 1;
    end
    // $finish;

  end

endmodule
