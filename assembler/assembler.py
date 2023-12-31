import argparse, enum, os


class Opcode(enum.Enum):
    R = 0b00
    I = 0b01
    B = 0b10
    M = 0b11

class RFunct(enum.Enum):
    ADD = 0b000
    AND = 0b001
    OR = 0b010
    XOR = 0b011

class IFunct(enum.Enum):
    ADDI = 0b0

class BFunct(enum.Enum):
    BEQ = 0b00
    BLT = 0b01

class Register(enum.Enum):
    X0 = 0b00
    X1 = 0b01
    X2 = 0b10
    X3 = 0b11


def main():
    #''' 
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-i", "--input_file",
        type=str,
        required=True,
        help="Assembly code to be assembled!",
    )
    parser.add_argument(
        "-o", "--output_file",
        type=str,
        required=True,
        help="File to be outputted.",
    )
    args = parser.parse_args()
    input_file = args.input_file
    assert (os.path.exists(input_file))
    #'''
    commands = []
    with open(input_file, 'r') as f: lines = f.readlines()
    lines = [line.strip() for line in lines]
    for line in lines:
        keywords = line.split(' ')
        keywords = [word.upper().replace(',', '') for word in keywords]
        assert len(keywords) > 0
        funct = keywords[0]
        if any(member.name == funct for member in RFunct):
            # R type
            assert len(keywords) == 4
            rd  = Register[keywords[1]]
            rs1 = Register[keywords[2]]
            rs2 = Register[keywords[3]]

            commands.append(f"{RFunct[funct].value:04b}_{rs2.value:02b}_{rs1.value:02b}_{rd.value:02b}_{Opcode['R'].value:02b}")
        elif any(member.name == funct for member in IFunct):
            # I type
            assert len(keywords) == 4
            rd  = Register[keywords[1]]
            rs1 = Register[keywords[2]]
            imm = int(keywords[3])
            assert -2**(6-1) <= imm <= (2**(6-1)) - 1

            commands.append(f"{imm:06b}_{rs1.value:02b}_{rd.value:02b}_{Opcode['I'].value:02b}")
        elif any(member.name == funct for member in BFunct):
            # B type
            assert len(keywords) == 3 
            rs1 = Register[keywords[1]]
            imm = int(keywords[2])
            assert imm <= (2**(6)) - 1

            commands.append(f"{imm:06b}_{rs1.value:02b}_{BFunct[funct].value:02b}_{Opcode['B'].value:02b}")
        else:
            assert(False), 'something went wrong!'

    print(commands)

if __name__ == '__main__':
    main()
