# glorbcore
Very basic RISC ISA core 


## Details
- instruction width = 8 bits
- data width = 8 bits (maybe 16) 
- registers = 4 (hard-coded zero + 3 general purpose)


### Register-Register Arithmetic Instructions:
    Operate between two registers (rs1 and rd). The result is stored in rd.

    8-bit decoding:
        7-6: rs1
        5-4: rd
        3-2: funct
        1-0: opcode (00)

    funct decoding:
        0: add
        1: and
        2: or
        3: xor

### Branch Instructions:
    Conditionally adds a number (imm) to the program counter

    8-bit decoding:
        7-2: imm 
        1  : funct
        0  : opcode (1)
 
    funct decoding:
        0: beq
        1: blt
