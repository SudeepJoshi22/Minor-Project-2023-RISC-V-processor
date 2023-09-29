#Aligning the instruction to byte oriented little-endian format
python3 align.py

iverilog -o top top_module_tb.v top_module.v core.v instr_mem.v data_mem.v IF.v IF_ID.v ID.v ID_EX.v EX.v EX_MEM.v MEM.v MEM_WB.v WB.v reg_file.v control_unit.v imm_gen.v alu.v PC_Src.v store_whb.v signext.v 
vvp top.vvp
gtkwave waveform.vcd &
