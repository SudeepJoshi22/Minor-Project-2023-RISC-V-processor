def generate_verilog_pipeline_registers():
    # User inputs
    stage_name1 = input("Enter the name for the first stage: ")
    stage_name2 = input("Enter the name for the second stage: ")

    input_signals = []
    while True:
        signal_name = input("Enter the input signal name (or 'q' to stop): ")
        if signal_name.lower() == 'q':
            break
        signal_width = int(input(f"Enter the signal width for {signal_name}: "))
        input_signals.append((signal_name, signal_width))

    # Write Verilog code to a .v file
    filename = f"{stage_name1}_{stage_name2}.v"
    with open(filename, "w") as f:
        f.write(f"module {stage_name1}_{stage_name2} (\n")
        f.write("    input wire clk,\n")
        f.write("    input wire rst,\n")

        # Input signals
        for signal_name, signal_width in input_signals:
            f.write(f"    input wire [{signal_width-1}:0] {signal_name},\n")

        # Output signals
        #f.write(f"    output reg clk, rst,\n")
        for signal_name, signal_width in input_signals:
            f.write(f"    output reg [{signal_width-1}:0] {signal_name}_{stage_name1}_{stage_name2},\n")

        f.write(");\n")
        f.write("\n")
        f.write("always @(posedge clk, negedge rst)\n")
        f.write("begin\n")
        f.write("    if (!rst)\n")
        f.write("    begin\n")

        # Reset values
        for signal_name, signal_width in input_signals:
            f.write(f"        {signal_name}_{stage_name1}_{stage_name2} <= {signal_width}'d0;\n")

        f.write("    end\n")
        f.write("    else\n")
        f.write("    begin\n")

        # Flip flop assignments
        for signal_name, _ in input_signals:
            f.write(f"        {signal_name}_{stage_name1}_{stage_name2} <= {signal_name};\n")

        f.write("    end\n")
        f.write("end\n")
        f.write("\n")
        f.write("endmodule\n")

    print(f"Verilog code generated and saved to {filename}")

# Call the function to generate the Verilog code
generate_verilog_pipeline_registers()

