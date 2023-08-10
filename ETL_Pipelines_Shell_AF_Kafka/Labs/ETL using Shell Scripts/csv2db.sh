#! /bin/bash

# This script
# Extracts data from /etc/passwd file into a CSV file.

# The csv data file contains the user name, user id and 
# home directory of each user account defined in /etc/passwd

# Transforms the text delimiter from ":" to ",".
# Loads the data from the CSV file into a table in PostgreSQL database.


# Extract phase

echo "Extracting data"

# Extract the columns 1 (user name), 2 (user id) and 
# 6 (home directory path) from /etc/passwd

echo cut -d":" -f 1,3,6 /etc/passwd 

cut -d":" -f 1,3,6 /etc/passwd > extracted-data.txt

# Transform phase

echo "Transforming Data"

# replace occurring
# echo tr ":" "," < extracted-data.txt

tr ":" "," < extracted-data.txt > transformed-data.csv


# Load phase
echo "Loading data"
# Send the instructions to connect to 'template1' and
# copy the file to the table 'users' through command pipeline.

echo "\c template1;\COPY users  FROM '/home/project/transformed-data.csv' DELIMITERS ',' CSV;" | psql --username=postgres --host=localhost
