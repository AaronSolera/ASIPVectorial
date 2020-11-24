#!/usr/bin/env python3
import numpy as np

VEC_REGS = 4

height = 4
width  = 4
scale  = 2

image = np.array((([10, 20] * int(width//2)) + 
	              ([30, 40] * int(width//2))) * int(width//2))

#Defines the new size of the matrix
output_width  = width  * scale
output_height = height * scale
#Finds the ratio of the new and old size
column_ratio = output_width  / width
row_ratio    = output_height / height
#Creates the output image
output_img = np.zeros(output_height * output_width).astype(int)
#Creates a vector for handle the pixel positions of the output image
positions = np.arange(0, VEC_REGS)

#Goes through all rows
i = 0
while (i < output_height):
	#Normalizes the current row-wise pixel position
	rw_i = int(i // row_ratio)
	rw_i = rw_i * width
	#Goes through all columns
	j = 0
	column_pos = np.arange(j, j + VEC_REGS)
	while (j < output_width):
		#Normalizes the current columns-wise pixels positions
		cw_j = (column_pos // column_ratio).astype(int)
		#Computes the interpolation column indices of the current row
		cw_j = cw_j + rw_i
		#Gets the pixel values from the input image
		values = image[cw_j]
		#Saves the pixels in the output image
		np.put(output_img, positions, values)
		#Advances to the next pixel positions in the output image
		positions = positions + VEC_REGS
		#Continues to the next columns
		column_pos = column_pos + VEC_REGS
		j          = j + VEC_REGS
	#Continues to the next row
	i = i + 1

print(output_img.reshape((output_width,output_height)))
