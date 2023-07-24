#!/bin/bash

# Function to generate a random number between 0 and 9 (inclusive)
function generate_random_number() {
  echo $((RANDOM % 10))
}

# Create the file
touch test.txt

# Generate and write 10 random numbers to the file
for ((i=0; i<10; i++)); do
  echo "$(generate_random_number)" >> test.txt
done

echo "10 random numbers between 0 and 9 have been written to test.txt."
