# Run sets of commands using conditional statements
# Create true/false comparisons with logical operators
# Use arithmetic operators to perform basic mathematical calculations
# Use list-like arrays to store and access data
# Execute repetitive tasks with for loops

# echo '#!/bin/bash' > conditional_script.sh - run from the comand line can create a new exectubale bash script

#!/bin/bash

# Ask the user a binary "yesr or no" store he user's answers in a variable
echo -n "Do you believe in the Matrix? : Y/N "
read user_answer

# Conditional Block to select a response for the user
if [ $user_answer == 'Y' ]
then
    echo "Sweet, I believe in the Matrix as well"
else
    echo 'I guess you took the blue pill'
fi