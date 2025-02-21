
PLATFORM_DIR = ~/OpenROAD-flow-scripts/flow/platforms/asap7

ASAP_SOURCES = \
  $(PLATFORM_DIR)/verilog/stdcell/asap7sc7p5t_AO_RVT_TT_201020.v \
  $(PLATFORM_DIR)/verilog/stdcell/asap7sc7p5t_INVBUF_RVT_TT_201020.v \
  $(PLATFORM_DIR)/verilog/stdcell/asap7sc7p5t_SIMPLE_RVT_TT_201020.v \
  $(PLATFORM_DIR)/verilog/stdcell/dff.v \
  $(PLATFORM_DIR)/verilog/stdcell/empty.v \
  $(PLATFORM_DIR)/work_around_yosys/asap7sc7p5t_OA_RVT_TT_201020.v

all: fir.out

fir.out: ../rtl/fir.v fir_tb.v
	iverilog -o fir.out ../rtl/fir.v fir_tb.v

fir_openroad.out: fir_tb.v
	iverilog -o fir_openroad.out fir_tb.v /home/stavros/OpenROAD-flow-scripts/flow/results/asap7/fir/base/6_final.v $(ASAP_SOURCES)

simulate: fir.out
	vvp ./fir.out

simulate_final:
	vvp fir_openroad.out 

clean:
	rm fir.out fir_openroad.out fir_tb.vcd
