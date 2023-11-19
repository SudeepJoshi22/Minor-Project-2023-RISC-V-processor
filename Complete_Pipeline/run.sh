#Aligning the instruction to byte oriented little-endian format
python3 align.py

iverilog -o top top_module_tb.v top_module.v core.v instr_mem.v data_mem.v IF.v ID.v EX.v MEM.v WB.v reg_file.v store_whb.v imm_gen.v control_unit.v alu.v PC_Src.v signext.v 
vvp top
gtkwave waveform.vcd &
