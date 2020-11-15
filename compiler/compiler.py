#!/usr/bin/env python3
import math

REGS_NUMBER = 16
IMM_BITS    = 13

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

def dec_to_bin(num: int, digits: int) -> str:
	return format(num, "0{}b".format(int(math.log2(digits))))

def branch_instr(instr_parts: list) -> str:
	print("Brach instruction")

	instr_code = str()

	#Constructs the instruction's code
	instr_code += op["branch"]

	return instr_code

def memory_instr(instr_parts: list) -> str:
	print("Memory instruction")

	instr_code = str()

	instr_mnemonic = instr_parts[INSTR_NAME][:3]
	instr_type     = instr_parts[INSTR_NAME][3:]

	#U = update data

	L = str(1) if (instr_mnemonic == "LDR") else str(0)

	#Constructs the instruction's code
	instr_code += op["memory"]
	instr_code += vctr[instr_type]
	instr_code += U
	instr_code += L
	instr_code += (str(0) * 7)

	return instr_code

def data_processing_inst(instr_parts: list)-> str:
	print("Data processing instruction")
	print(instr_parts)

	instr_code = str()

	instr_mnemonic = instr_parts[INSTR_NAME][:3]
	instr_type = str()
	F          = str()

	if (len(instr[INSTR_NAME]) <= 5):
		tmp = instr_parts[INSTR_NAME][3:] if (len(instr_parts[INSTR_NAME]) > 3) else ""
		if (tmp == "EQ"):
			instr_type = ""
			F          = str(1)
		else:
			instr_type = tmp
			F          = str(0) 
	else: 
		F = str(1)
		if (len(instr[INSTR_NAME]) == 6):
			instr_type = instr_parts[INSTR_NAME][3:4]
		else:
			instr_type = instr_parts[INSTR_NAME][3:5]

	dest = dec_to_bin(int(instr_parts[DEST][1:]), REGS_NUMBER)
	src1 = dec_to_bin(int(instr_parts[SRC1][1:]), REGS_NUMBER)
	src2 = str()
	I    = str()

	#The second operand is a register
	if (instr_parts[SRC2][0] != "#"):
		I    = str(0)
		src2 = (str(0) * (IMM_BITS - int(math.log2(REGS_NUMBER)))) + dec_to_bin(int(instr_parts[SRC2][1:]), REGS_NUMBER)
	#The second operand is an immediate
	else:
		I    = str(1)
		src2 = dec_to_bin(int(instr_parts[SRC2][1:]), 2**IMM_BITS)

	#Constructs the instruction's code
	instr_code += op["data_processing"]
	instr_code += vctr[instr_type]
	instr_code += I 
	instr_code += F
	instr_code += cmd[instr_mnemonic]
	instr_code += dest
	instr_code += src1
	instr_code += src2

	print("{} {} {} {} {} {} {} {}".format(op["data_processing"], vctr[instr_type], I, F, cmd[instr_mnemonic], dest, src1, src2))

	return instr_code

code_file     = open("code.txt",  "r")
assembly_file = open("hexa.data", "w")

#Gets all the lines of code file
code_lines = code_file.readlines()

line_number = 1

#Goes through all the code lines
for line in code_lines:

	#Reads current instruction
	instr = line.strip().upper()

	if (not instr):
		#Continues to next line
		line_number += 1
		continue 

	#Gets instruction's parts
	instr_parts = instr.replace(",", " ").split()
	#Variable to store instruction's code
	instr_code = str()
	#Gets instruction's name
	instr_name = instr_parts[0]
	#BRANCH instruction
	if (instr_name[0] == "B"):
		instr_code = branch_instr(instr_parts)
	#MEMORY instruction
	elif (instr_name[0:2] == "ST" or instr_name[0:2] == "LD"):
		instr_code = memory_instr(instr_parts)
	#DATA PROCESSING instruction
	else:
		instr_code = data_processing_inst(instr_parts)

	#Continues to next line
	line_number += 1

	print()

