# Variables
# If you add any new Verilog file to the design add it in the "VERILOG_FILE" variable.
VERILOG_FILES := top_module_tb.v top_module.v core.v instr_mem.v data_mem.v IF.v ID.v EX.v MEM.v WB.v reg_file.v store_whb.v imm_gen.v control_unit.v alu.v PC_Src.v signext.v
MEM_FILE := memory.out
PYTHON_SCRIPT := align.py
WAVEFORM_VIEWER := gtkwave

# Targets
all: init core

init:
	@echo "Initializing..."
	sudo apt update
	sudo apt install -y iverilog gtkwave

core: $(VERILOG_FILES)
	@echo "Cleaning the log files..."
	rm -f output.vvp waveform.vcd core.vvp *_tb.vvp *.log
	@echo "Aligning the Memory to Little Endian..."
	python3 $(PYTHON_SCRIPT)	
	@echo "Compiling Verilog files..."
	iverilog -o output.vvp $(VERILOG_FILES)
	vvp output.vvp
	@echo "Generating waveform..."
	gtkwave waveform.vcd &
	cat register_file.log
	cat data_memory.log

compile: $(TB) $(DESIGN)
	@echo "Compiling Verilog files..."
	iverilog -o output.vvp $(TB) $(DESIGN)
	vvp output.vvp
	@echo "Generating waveform..."
	gtkwave waveform.vcd

clean:
	@echo "Cleaning up..."
	rm -f output.vvp waveform.vcd core.vvp *_tb.vvp *.log

.PHONY: all core compile clean

