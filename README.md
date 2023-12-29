# glorbcore
Very basic RISC ISA core 


## Details
- instruction width = 12 bits
- data width = 12 bits (maybe 16 eventually) 
- registers = 5 (hard-coded zero + 3 general purpose + hidden stack-pointer register)


### Register-Register Arithmetic Instructions:
    Operate between two registers (rs1 and rs2) and store result in rd.

    12-bit decoding:
        12-8: funct
        7-6: rs2
        5-4: rs1
        3-2: rd
        1-0: opcode (00)

    funct decoding:
        0: add
        1: and
        2: or
        3: xor
        4-8: not implemented

### Immediate-Register Aritmetic Instructions:
    Add a register (rs1) to an immediate value (imm). Store result in rd.

    12-bit decoding:
        12-6: imm
        5-4: rs1
        3-2: rd
        1-0: opcode (01)

### Branch Instructions:
    Compares a register value (rs1). If true, it adds (imm) to the program counter

    12-bit decoding:
        12-6: imm
        5-4: rs1
        3-2: funct
        1-0: opcode (10)

 
    funct decoding:
        0: beq (rs1 == 0)
        1: blt (rs1 < 0)
        2-3: not implemented

### Memory (Stack) Instructions:
    TBD
