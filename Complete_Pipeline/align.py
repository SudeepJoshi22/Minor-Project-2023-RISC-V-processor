# Open the input file (memory.out) for reading and the output file (memory.mem) for writing
with open('memory.out', 'r') as infile, open('memory.mem', 'w') as outfile:
    # Read each line from the input file
    for line in infile:
        # Remove '0x' from the beginning of each line and convert it to an integer
        hex_value = int(line.strip(), 16)
        
        # Convert the integer to a byte array with little-endian byte order
        byte_array = hex_value.to_bytes(4, byteorder='little')
        
        # Write the byte array to the output file in the desired format
        outfile.write(' '.join(format(byte, '02x') for byte in byte_array))
        outfile.write('\n')

