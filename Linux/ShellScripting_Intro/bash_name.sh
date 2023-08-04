# This script accepts the user\'s name and prints a message greeting the user

# print the prompt message on screen
echo -n "Enter your name :"

# Wait for the user to enter a name, and save the enter name into a variable using 'read'
read name

# Print the a welcome message
echo "Welcome $name"

# echo out script ending on new line
echo -n "First list intro bash script for collecting user input and assigning to a variable "
echo -n 'using Bash!'