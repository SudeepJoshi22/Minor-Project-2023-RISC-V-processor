import re

def extract_module_name(file_path):
    with open(file_path, 'r') as f:
        content = f.read()

    module_pattern = r'\bmodule\b\s+(\w+)\s*\(.*\);'
    match = re.search(module_pattern, content)
    if match:
        module_name = match.group(1)
        return module_name
    else:
        return None

def generate_instantiation(module_name, signal_name):
    instantiation = f"{module_name} {signal_name} (\n"
    instantiation += "  // Connect your ports here\n"
    instantiation += ");\n"
    return instantiation

if __name__ == "__main__":
    verilog_file = input("Enter the name of the Verilog file: ")
    signal_name = input("Enter the name for the instantiation: ")

    module_name = extract_module_name(verilog_file)

    if module_name:
        instantiation_code = generate_instantiation(module_name, signal_name)

        with open("instantiation_output.txt", "w") as f:
            f.write(instantiation_code)

        print(f"Instantiation of {module_name} saved in instantiation_output.txt.")
    else:
        print("Failed to extract module name from the Verilog file.")

