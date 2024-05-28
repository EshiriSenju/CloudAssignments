#!/bin/bash

# Prompt the user to enter a number
read -p "Enter a number: " number

# Check if the number is positive, negative, or zero
if (( $(echo "$number > 0" | bc -l) )); then
    echo "The number is positive."
elif (( $(echo "$number < 0" | bc -l) )); then
    echo "The number is negative."
else
    echo "The number is zero."
fi
