#!/bin/bash

# Tell the user to enter the base and height of the triangle
read -p "Enter the base of the triangle: " base
read -p "Enter the height of the triangle: " height

# Calculate the area of the triangle
area=$(echo "0.5 * $base * $height" | bc -l)

# Print the area
echo "The area of the triangle is $area"
