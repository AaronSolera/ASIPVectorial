#!/usr/bin/env python3
import numpy as np

img        = [10, 4, 22, 2, 18, 7, 9, 14, 25]
img_width  = 3
img_height = 3

img        = [10, 20, 30, 40]
img_width  = 2
img_height = 2

scale = 2

def cn_interpolation(image: list, width: int, height: int, scale: int) -> list:
	image = np.array(image)
	#Defines the new size of the matrix
	output_width  = width  * scale
	output_height = height * scale
	#Finds the ratio of the new and old size
	column_ratio = output_width  / width
	row_ratio    = output_height / height 
	#Normalizes the row-wise and columns-wise pixel positions
	column_pos = np.arange(0, output_width)  / column_ratio
	row_pos    = np.arange(0, output_height) / row_ratio
	#Uses floor function that gives the least integer lower than the value
	column_pos = np.floor(column_pos).astype(int)
	row_pos    = np.floor(row_pos).astype(int) * width
	#Creates the ouotput image
	output_img = np.zeros(output_width * output_height).astype(int)
	#Goes through all columns
	j = 0
	while (j < output_width):
		#Determines the interpolation column index of the current column
		cw_j = column_pos[j]
		#Computes the interpolation row indices of the current column
		curr_row_pos = row_pos + cw_j
		#Goes through all rows
		i = 0
		while (i < output_height):
			index             = curr_row_pos[i]
			value             = image[index]
			index             = j + i * output_width
			output_img[index] = value
			#Continues to the next row
			i += 1
		#Cotinues to the next column
		j += 1
	return output_img

def cn_interpolation_v2(image: list, width: int, height: int, scale: int) -> list:
	image = np.array(image)
	#Defines the new size of the matrix
	output_width  = width  * scale
	output_height = height * scale
	#Finds the ratio of the new and old size
	column_ratio = output_width  / width
	row_ratio    = output_height / height 
	#Normalizes the row-wise and columns-wise pixel positions
	column_pos = np.arange(0, output_width)  / column_ratio
	row_pos    = np.arange(0, output_height) / row_ratio
	#Uses floor function that gives the least integer lower than the value
	column_pos = np.floor(column_pos).astype(int)
	row_pos    = np.floor(row_pos).astype(int) * width
	#Creates the ouotput image
	output_img = np.zeros(output_width * output_height).astype(int)
	#Goes through all rows
	i = 0
	while (i < output_height):
		#Determines the interpolation row index of the current column
		rw_i = row_pos[i]
		#Computes the interpolation column indices of the current column
		curr_row_pos          = column_pos + rw_i
		start                 =  i    * output_width
		end                   = (i+1) * output_width
		output_img[start:end] = image[curr_row_pos]
		#Continues to the next row
		i += 1
	return output_img

def bi_interpolation(image: list, width: int, height: int, zoom: int) -> list:
	#Defines the new size of the matrix
	output_width  = width  * scale
	output_height = height * scale
	#Creates the ouotput image
	output_img = np.zeros(output_width * output_height).astype(int)
	#
	output_img[0]                                                 = image[0]
	output_img[output_width-1]                                    = image[width-1]
	output_img[(output_height-1)*(output_width)]                  = image[(height-1)*(width)]
	output_img[(output_width-1)+(output_height-1)*(output_width)] = image[(width-1)+(height-1)*(width)]
	#Goes through the first and the last column
	j  = 0
	while (j < output_width):
		#
		y1 = j + 1
		y2 = (output_height - 1) * output_width + y1
		d  = y2 - y1 
		#
		Qa = output_img[y1 - 1]
		Qb = output_img[y2 - 1]
		#Goes through all rows (not including edges)
		i = 1
		while (i < output_height - 1):
			#
			index = j + i * output_width
			#
			y  = index + 1
			#
			w1 = (y2 - y)  / d
			w2 = (y  - y1) / d
			#
			r1 = w1 * Qa
			r2 = w2 * Qb
			#
			output_img[index] = round(r1 + r2)
			#
			i += 1
		#
		j += output_width - 1

	#Goes through all rows
	i = 0
	while (i < output_height):
		#
		x1 = (i * output_width)
		x2 = x1 + output_width
		x1 += 1
		d  = x2 - x1 
		#
		Qa = output_img[x1 - 1]
		Qb = output_img[x2 - 1]
		#Goes through all columns (not including edges)
		j = 1
		while (j < output_width - 1):
			#
			index = j + i * output_width
			#
			x  = index + 1
			#
			w1 = (x2 - x)  / d
			w2 = (x  - x1) / d
			#
			r1 = w1 * Qa
			r2 = w2 * Qb
			#
			output_img[index] = round(r1 + r2)
			#
			j += 1
		#Continues to the next row
		i += 1
	return output_img

print(np.array(bi_interpolation(img, img_width, img_height, scale)).reshape((img_width*scale,img_height*scale)))

#print(np.array(bi_interpolation(img, img_width, img_height, scale)))
