#!/usr/bin/env python3
import numpy as np
from PIL import Image

VEC_REGS = 4

height = 512
width  = 512
scale  = 2
scale2 = scale * scale

input_img_name  = "lion.png"
output_img_name = "lion_bi.png"

input_img        = Image.open(input_img_name)

image = np.array(list(input_img.getdata()), dtype=np.uint8)

#Defines the new size of the matrix
output_width  = width  * scale
output_height = height * scale
#Finds the ratio of the new and old size
column_ratio = output_width  / width
row_ratio    = output_height / height
#Creates the output image
output_img = np.zeros(output_height * output_width).astype(int)

#---------------------------------------------------------------------------------
# Maps the known pixels from the input image to the output image
#---------------------------------------------------------------------------------
#Goes through all rows
i  = 0
ki = 1
while (i < output_height):
	#Normalize the row position for the input image
	input_i = int(i // row_ratio)
	#Goes through all columns
	j  = 0
	while (j < output_width):
		#Calculates the indices of the current pair
		x1 = j
		x2 = j + scale + 1
		#Calculates the current pair position in the output image
		output_pos1 = x1 + i * output_width
		output_pos2 = x2 + i * output_width
		#Normalize the columns position for the input image
		input_x1 = int(x1 // scale)
		input_x2 = int(x2 // scale)
		#Calculates the current pair position in the input image
		input_pos1 = input_x1 + input_i * width
		input_pos2 = input_x2 + input_i * width
		#Gets the pixel values of the current pair
		Qa = image[input_pos1]
		Qb = image[input_pos2]
		#Stores the pixel values in the output image
		output_img[output_pos1] = Qa
		output_img[output_pos2] = Qb
		#Continues to the next columns
		j = j + VEC_REGS
	#The current pair has not finished mapping 
	if (ki < scale):
		#Continues to the other row in the current pair
		i  = i + (VEC_REGS - 1)
		ki = ki + 1
	else:
		#Continues to the next row
		i  = i + 1
		ki = 1

#print(output_img.reshape((output_width,output_height)))
#print()

#---------------------------------------------------------------------------------
# Computes the first linear interpolation
#---------------------------------------------------------------------------------
#Goes through the first and the last column
j  = 0
kj = 1
while (j < output_width):
	#Goes through all rows
	i = 0
	while (i < output_height):
		#Calculates the indices of the current pair
		y1 = i
		y2 = y1 + scale + 1
		#Calculates the distance of the current pair
		d  = y2 - y1 
		#Calculates the current pair position in the output image
		output_pos1 = j + y1 * output_width
		output_pos2 = j + y2 * output_width
		#Gets the pixel values of the current pair
		Qa = output_img[output_pos1]
		Qb = output_img[output_pos2]
		#Goes through all intermediate pixels of the current pair
		y = y1 + 1
		while (y < y2):
			#Calculates the position of the current pixel
			index = j + y * output_width
			#Calculates the weights for the current position between the pair
			w1 = (y2 - y)
			w2 = (y  - y1)
			#Calculates the ratio of the weights for the current position between the pair
			r1 = (w1 * Qa) / d
			r2 = (w2 * Qb) / d
			value = round(r1 + r2)
			#Saves the pixel value in the output image
			output_img[index] = value
			#Continues to the next row
			y = y + 1
		#Continues to the next row pair
		i = i + scale * scale
	#The current pair has not finished interpolating
	if (kj < scale):
		#Continues to the other column in the current pair
		j  = j + (VEC_REGS - 1)
		kj = kj + 1
	else:
		#Continues to the next column
		j  = j + 1
		kj = 1

#print(output_img.reshape((output_width,output_height)))
#print()

#---------------------------------------------------------------------------------
# Computes the second linear (bilinear) interpolation
#---------------------------------------------------------------------------------
#Creates a vector for handle the pixel positions of the output image
positions = np.arange(0, VEC_REGS)
#Calculates the indices of the current pair
x1 = 0
x2 = (VEC_REGS - 1)
#Goes through all rows
i = 0
while (i < output_height):
	#Goes through all columns
	j = 0
	while (j < output_width):
		#Calculates the distance of the current pair
		d = x2 - x1
		#Gets the pixel values of the current pair
		Qa = output_img[x1]
		Qb = output_img[x2]
		#Calculates the weights for each position between the current pair
		w1 = (x2 - positions)
		w2 = (positions - x1)
		#Calculates the ratio of the weights for each position between the current pair
		r1 = (w1 * Qa) / d
		r2 = (w2 * Qb) / d
		values = np.round(r1 + r2)
		#Saves the pixels values in the output image
		np.put(output_img, positions, values)
		#Advances to the next pixel positions in the output image
		positions = positions + VEC_REGS
		x1 = x1 + VEC_REGS
		x2 = x2 + VEC_REGS
		#Continues to the next columns
		j = j + VEC_REGS
	#Continues to the next row
	i = i + 1

output_image = Image.new(mode="L", size=(output_width, output_height))
output_image.putdata(output_img.flatten())

output_image.save(output_img_name)

#print(output_img.reshape((output_width,output_height)))
