

all: fir.out

fir.out: ../rtl/fir.v fir_tb.v
	iverilog -o fir.out ../rtl/fir.v fir_tb.v

simulate: fir.out
	vvp ./fir.out

clean:
	rm fir.out fir_tb.vcd
