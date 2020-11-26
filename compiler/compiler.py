#!/usr/bin/env python3
import math

HIGH = 1
LOW  = 0

REGS_NUMBER = 16
IMM_BITS    =  9
LABEL_NAME  =  1

INSTR_NAME = 0
DEST       = 1
SRC1 	   = 2
SRC2       = 3

op = {"data_processing" : "00",
	  "memory"          : "01",
	  "branch"          : "10"}

vctr = {""   : "00",
        "VS" : "10",
        "V"  : "11"}

cmd = {"ADD" : "000", 
	   "SUB" : "001",
	   "MUL" : "010",
	   "DIV" : "011",
	   "MOV" : "100",
	   "CMP" : "101"}

flags = {""   : "11",
		 "EQ" : "10",
		 "LT" : "01",
		 "GT" : "00"}

labels = dict()


def dec_to_bin(num: int, digits: int) -> str:
	return format(num, "0{}b".format(int(math.log2(digits))))


def write_stall() -> None:
	assembly_file.write("{}\n".format(32 * str(0)))


def branch_instr(instr_parts: list) -> str:
	instr_code = str()
	instr_cond = instr_parts[INSTR_NAME][1:]

	#Constructs the instruction's code
	instr_code += op["branch"]
	instr_code += flags[instr_cond]
	instr_code += (19 * str(0))
	instr_code += dec_to_bin(int(labels[instr_parts[LABEL_NAME]]), 2**IMM_BITS)

	print("{} = {} {} {} {}".format(len(instr_code), op["branch"], flags[instr_cond], 19*str(0), dec_to_bin(int(labels[instr_parts[LABEL_NAME]]), 2**IMM_BITS)))

	return instr_code


def memory_instr(instruction: list) -> str:
	inst_code = str()
	U    = str()
	L    = str()
	S    = str()
	E    = str()
	dest = str()
	src1 = str()
	src2 = str()
	POS  = str()
	imm  = str()

	instr_mnemonic = instruction[INSTR_NAME][:2]
	instr_type     = instruction[INSTR_NAME][2:]

	U = str(HIGH) if ("!" in instruction) else str(LOW)

	L = str(HIGH) if (instr_mnemonic == "LD") else str(LOW)

	if ((">" in instruction) or ("<" in instruction)):
		S = str(HIGH)
		E = str(LOW)

		if (">" in instruction):
			POS = dec_to_bin(0, 2)
		else:
			POS = dec_to_bin(1, 2)

	elif (instruction[INSTR_NAME] == "LD"):
		if (len(instruction) == 3):
			S   = str(LOW)
			E   = str(LOW)
			POS = dec_to_bin(0, 2)
		else:
			S   = str(HIGH)
			E   = str(HIGH)
			POS = dec_to_bin(int(instruction[-1]), 2)

	else:
		S   = str(LOW)
		E   = str(LOW)
		POS = (2 * str(0))

	if (int(L) == 1):
		dest = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER) #Rd
		src1 = dec_to_bin(int(instruction[SRC1][1:]), REGS_NUMBER) #Rn
		src2 = dec_to_bin(0, REGS_NUMBER)
	else:
		dest = dec_to_bin(0, REGS_NUMBER)                          #Rd
		src1 = dec_to_bin(int(instruction[SRC1][1:]), REGS_NUMBER) #Rn
		src2 = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER) #Rm
		
	#The second operand is an immediate
	if (any("#" in c for c in instruction)):
		imm = dec_to_bin(int(instruction[SRC2][1:]), 2**IMM_BITS)

	else:
		imm = dec_to_bin(0, 2**IMM_BITS)

	#Constructs the instruction's code
	inst_code += op["memory"]
	inst_code += vctr[instr_type]
	inst_code += U
	inst_code += L
	inst_code += S
	inst_code += E
	inst_code += str(0)
	inst_code += dest
	inst_code += src1
	inst_code += src2
	inst_code += POS
	inst_code += imm

	print("{} = {} {} {} {} {} {} {} {} {} {} {} {}".format(len(inst_code), op["memory"], vctr[instr_type], U, L, S, E, str(0), dest, src1, src2, POS, imm))

	return inst_code


def data_processing_inst(instruction: list)-> str:
	inst_code = str()
	I         = str()
	F         = str()
	dest      = str()
	src1      = str()
	src2      = str()
	imm       = str()

	instr_mnemonic = instruction[INSTR_NAME][:3]
	instr_type     = str()

	if (len(instruction[INSTR_NAME]) <= 5):
		tmp = instruction[INSTR_NAME][3:] if (len(instruction[INSTR_NAME]) > 3) else ""
		if (tmp == "EQ"):
			instr_type = ""
			F          = str(HIGH)
		else:
			instr_type = tmp
			F          = str(LOW) 
	else: 
		F = str(1)
		if (len(instr[INSTR_NAME]) == 6):
			instr_type = instruction[INSTR_NAME][3:4]
		else:
			instr_type = instruction[INSTR_NAME][3:5]

	#The second operand is an immediate
	if (any("#" in c for c in instruction)):
		I = str(HIGH)

	#The second operand is a register
	else:
		I = str(LOW)

	if (instr_mnemonic == "MOV"):

		if (int(I)):
			dest = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER)
			src1 = dec_to_bin(0, REGS_NUMBER)
			src2 = dec_to_bin(0, REGS_NUMBER)
			imm  = dec_to_bin(int(instruction[SRC1][1:]), 2**IMM_BITS)

		else:
			dest = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER)
			src1 = dec_to_bin(int(instruction[SRC1][1:]), REGS_NUMBER)
			src2 = dec_to_bin(0, REGS_NUMBER)
			imm  = dec_to_bin(0, 2**IMM_BITS)

	elif (instr_mnemonic == "CMP"):

		dest = dec_to_bin(0, REGS_NUMBER)

		if (int(I)):
			src1 = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER)
			src2 = dec_to_bin(0, REGS_NUMBER)
			imm  = dec_to_bin(int(instruction[SRC1][1:]), 2**IMM_BITS)

		else:
			src1 = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER)
			src2 = dec_to_bin(0, REGS_NUMBER)
			imm  = dec_to_bin(0, 2**IMM_BITS)

	else:
		dest = dec_to_bin(int(instruction[DEST][1:]), REGS_NUMBER)
		src1 = dec_to_bin(int(instruction[SRC1][1:]), REGS_NUMBER)

		if (int(I)):
			src2 = dec_to_bin(0, REGS_NUMBER)
			imm  = dec_to_bin(int(instruction[SRC2][1:]), 2**IMM_BITS)

		else:
			src2 = dec_to_bin(int(instruction[SRC2][1:]), REGS_NUMBER)
			imm  = dec_to_bin(0, 2**IMM_BITS)

	#Constructs the instruction's code
	inst_code += op["data_processing"]
	inst_code += vctr[instr_type]
	inst_code += I 
	inst_code += F
	inst_code += cmd[instr_mnemonic]
	inst_code += dest
	inst_code += src1
	inst_code += src2
	inst_code += (2 * str(0))
	inst_code += imm

	print("{} = {} {} {} {} {} {} {} {} {} {}".format(len(inst_code), op["data_processing"], vctr[instr_type], I, F, cmd[instr_mnemonic], dest, src1, src2, 2*str(0), imm))

	return inst_code


code_file     = open("code.txt",  "r")
assembly_file = open("code.bin", "w")

#Gets all the non-blank lines of code file
code_lines = [line for line in code_file.readlines() if line.strip()]

#Obtiene las lineas de instrucciones de manera bonita
for i in range(len(code_lines)):
	code_lines[i] = code_lines[i].strip().upper().split(";")[0].replace(",", " ").replace("[", " ").replace("]", " ").split()

#Coloca los stall necesarios entre las instrucciones
tmp_code_lines = list()
for i in range(len(code_lines)):
	curr_inst = code_lines[i]
	tmp_code_lines.append(curr_inst)
	if (i < (len(code_lines) - 1)):
		next_inst = code_lines[i+1]
		if (curr_inst[INSTR_NAME][:2] == "LD" and next_inst[INSTR_NAME][:2] == "ST"):
			tmp_code_lines.append(["NOP"])
		elif (curr_inst[INSTR_NAME][:1] == "B"):
			tmp_code_lines.append(["NOP"])
			tmp_code_lines.append(["NOP"])
			tmp_code_lines.append(["NOP"])
			tmp_code_lines.append(["NOP"])
			tmp_code_lines.append(["NOP"])
code_lines = tmp_code_lines

#Coloca NOP entre las instrucciones	que presentan dependencias
tmp_code_lines = list()
set_number = 3
for i in range(len(code_lines)):
	curr_inst  = code_lines[i]
	tmp_code_lines.append(curr_inst)
	if (len(curr_inst) > 1):
		next_insts = list()
		j = i + 1
		if (i < (len(code_lines) - set_number)):
			next_insts = code_lines[j:j+set_number]
		else:
			next_insts = code_lines[j:j+(len(code_lines) - i)]

		curr_inst_dest = curr_inst[DEST]

		no_operations_number = 0

		for k in range(len(next_insts)):

			if (len(next_insts[k]) == 1 or len(next_insts[k]) == 2):
				continue

			elif (next_insts[k][INSTR_NAME] == "MOV"):

				if (curr_inst_dest == next_insts[k][SRC1]):
					no_operations_number = set_number - k
					break

			elif (next_insts[k][INSTR_NAME] == "CMP" or next_insts[k][INSTR_NAME][:2] == "ST" or next_insts[k][INSTR_NAME][:2] == "LD"):

				if (curr_inst_dest == next_insts[k][DEST] or curr_inst_dest == next_insts[k][SRC1]):
					no_operations_number = set_number - k
					break

			else:

				if (curr_inst_dest == next_insts[k][SRC1] or curr_inst_dest == next_insts[k][SRC2]):
					no_operations_number = set_number - k
					break

		for j in range(no_operations_number):
			tmp_code_lines.append(["NOP"])

code_lines = tmp_code_lines

for i in range(len(code_lines)):
	print("{} - {}".format(i, code_lines[i]))

print()

#Goes through all the code lines
for i in range(len(code_lines)):

	instruction = code_lines[i]

	#Variable to store instruction's code
	inst_code = str()

	if (instruction[0] == "NOP"):
		inst_code += (str(11) + (30 * str(0)))

	else:

		#Current line is a label
		if (len(instruction) == 1):
			labels[instruction[0][:-1]] = i
			continue

		#Gets instruction's name
		instr_name = instruction[0]

		#BRANCH instruction
		if (instr_name[0] == "B"):
			inst_code = branch_instr(instruction)
		#MEMORY instruction
		elif (instr_name[0:2] == "ST" or instr_name[0:2] == "LD"):
			inst_code = memory_instr(instruction)
		#DATA PROCESSING instruction
		else:
			inst_code = data_processing_inst(instruction)

	#print(" {}".format(inst_code))

	#Writes the instruction code in the assembly file
	assembly_file.write("{}\n".format(inst_code))
