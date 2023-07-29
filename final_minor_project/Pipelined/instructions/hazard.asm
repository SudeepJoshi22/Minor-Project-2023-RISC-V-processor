.global main

.text
main:
    addi t0, zero, 0x07FF
    slli t1, t0, 0xF
    add t1, t1, t0

    # Insert NOP (addi x0, x0, 0) to handle potential WAR hazard on t0
    addi x0, x0, 0

    srli t0, t0, 0x8
    xori t0, t0, 0x07F

    # Insert NOP (addi x0, x0, 0) to handle potential WAR hazard on t0
    addi x0, x0, 0

    andi t0, t0, 0x7F0
    ori t0, t0, 0x0FF
    sw t1, 0(zero)
    sh t1, 4(zero)
    sb t1, 8(zero)

    # Insert NOP (addi x0, x0, 0) to handle potential WAR hazard on t1
    addi x0, x0, 0

    # Load data back from memory to t2, t3, and t4
    lw t2, 0(zero)
    lh t3, 4(zero)
    lb t4, 8(zero)

    # Insert NOP (addi x0, x0, 0) to handle potential WAR hazard on t3 and t4
    addi x0, x0, 0

    add t2, t2, t3
    sub t3, t2, t4
    sll t3, t4, t2
    srl t3, t4, t2
    xor t2, t3, t4
    and t2, t3, t4
    or t2, t3, t4

    # Insert NOP (addi x0, x0, 0) as a precautionary measure to handle any potential RAW hazards
    addi x0, x0, 0
