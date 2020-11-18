from PIL import Image

#----------------------------------------------------------------------------------------------
#   For more information about Hexadecimal (Intel-Format) File (.hex) go to
#   https://www.intel.com/content/www/us/en/programmable/quartushelp/13.0/mergedProjects/reference/glossary/def_hexfile.htm
#----------------------------------------------------------------------------------------------

print('-'*30)
print('Image file to hex file converter')
print('-'*30)

#----------------------------------------------------------------------------------------------
#   Code make by John Zwinck available at
#   https://stackoverflow.com/questions/43119486/calculate-checksum-hex-in-python-3
#----------------------------------------------------------------------------------------------
def checksum(a):
    b = [a[i:i+2] for i in range(0, len(a), 2)]
    c = [int(i, 16) for i in b] 
    d = 256 - sum(c) % 256 
    return f'{d:0>2X}'[-2:]
#----------------------------------------------------------------------------------------------
#   Getting image data from user
#----------------------------------------------------------------------------------------------
img_path = input('Image path: ')
word_length = int(input('Word length: '))
number_of_words = int(input('Number of words: '))

img = Image.open(img_path, 'r')
pix = img.load()

hex_file = open("MEMORY.hex", "w")
#----------------------------------------------------------------------------------------------
#   Setting Hexadecimal (Intel-Format) relevant variables
#----------------------------------------------------------------------------------------------
bytes_in_data = int(word_length / 8)
starting_address = 0
line_type = '00'
data_field = ''
current_byte = 0
#----------------------------------------------------------------------------------------------
#   Inserting byte by byte all image pixels in hex file
#----------------------------------------------------------------------------------------------
for row in range(img.size[0]):
    for column in range(img.size[1]):
        data_field = data_field + f'{pix[column,row]:0>2X}'
        current_byte += 1
        if current_byte == bytes_in_data:
            content = f'{bytes_in_data:0>2X}' + f'{starting_address:0>4X}'[-4:] + line_type + data_field
            hex_file.write(':' + content + checksum(content) + '\n')
            data_field = ''
            current_byte = 0
            starting_address += 1
#----------------------------------------------------------------------------------------------
#   Inserting the rest of non set data to complete the number of words
#----------------------------------------------------------------------------------------------
data_field = '00' * bytes_in_data

for address in range(starting_address, number_of_words):
    content = f'{bytes_in_data:0>2X}' + f'{address:0>4X}'[-4:] + line_type + data_field
    hex_file.write(':' + content + checksum(content) + '\n')

#----------------------------------------------------------------------------------------------
#   Inserting end of file delimiter to complete convertion
#----------------------------------------------------------------------------------------------
line_type = '01'
bytes_in_data = 0
starting_address = 0

content = f'{bytes_in_data:0>2X}' + f'{starting_address:0>4X}'[-4:] + line_type
hex_file.write(':' + content + checksum(content) + '\n')

print('Image has been converted to hex file successfully')
hex_file.close()
img.close()
