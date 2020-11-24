#!/usr/bin/env python3
from PIL import Image
import numpy as np

def embarrar(pixels: list, direction: str) -> list:
	output_pixels = list()
	if (direction == "<"):
		output_pixels = ([pixels[0]] * 2) + ([pixels[1]] * 2)
	elif (direction == ">"):
		output_pixels = ([pixels[2]] * 2) + ([pixels[3]] * 2)
	return output_pixels
#
img_size = 512
#---------------------------------------------------------
pixels_total = img_size * img_size
input_img_name  = "lion.png"
output_img_name = "lioni.png"

input_img        = Image.open(input_img_name)
#---------------------------------------------------------
switch = 6 
# 
size  = int(img_size / 4)
#
scale = 2
# 
quadrant_row = int(switch / 4)
#
quadrant_column = switch - ( int(i / 4) * 4 )
#
quadrant_size = int(size / 4)
#---------------------------------------------------------
#
image = np.array(list(input_img.getdata()), dtype=np.uint8).reshape((int(pixels_total // 4), 4))
#Defines the new size of the matrix
output_size = size * scale
#Creates the output image
output_img = np.array([[0] * 4] * (int(output_size**2 // 4)))
#
img_temp = np.array([[0] * 4] * (int(128**2 // 4)))
#---------------------------------------------------------
#
i = 0
#
j = 0
#
k = 0
#
quadrant_row_offset = (quadrant_row * size) * size
#
while j < size - 1: #!!!!!!! Ese menos uno hablarlo con Nacho
	#
	while i < quadrant_size:
		#
		quadrant_column_offset = (size * j) + (quadrant_column * quadrant_size) + i 
		#
		quadrant_offset = quadrant_row_offset + quadrant_column_offset
		#---------------------------------------------------------
		img_temp[i + (quadrant_size * j)] = image[quadrant_offset]
		#---------------------------------------------------------
		while k < scale:
			#
			value = embarrar(image[quadrant_offset], "<")
			# 
			offset = (i * 2 + (quadrant_size * 4 * j))
			#
			offset = offset + k
			#
			output_img[offset] = value 
			#
			output_img[(quadrant_size * 2) + offset] = value 
			#
			value = embarrar(image[quadrant_offset], ">")
			#
			output_img[offset + 1] = value
			#
			output_img[(quadrant_size * 2) + offset + 1] = value 
			#
			k += 1
		#
		k  = 0
		#
		i += 1
	#
	i = 0
	#
	j += 1
#---------------------------------------------------------
output_image = Image.new(mode="L", size=(output_size, output_size))
output_image.putdata(output_img.flatten())

output_image.save(output_img_name)

output_image = Image.new(mode="L", size=(size, size))
output_image.putdata(img_temp.flatten())

output_image.save("control.png")
#---------------------------------------------------------
