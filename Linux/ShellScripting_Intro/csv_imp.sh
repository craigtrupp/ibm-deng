#!/bin/bash

# download a csv file to current working directory
csv_file="https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-LX0117EN-SkillsNetwork/labs/M3/L2/arrays_table.csv"
wget $csv_file
# This then assigns the imported csv file (basically an api response more or less to a variable we can parse into columns)
csv_file_conts='arrays_table.csv'

# Display csv file (file has been downloaded into directory as array_table.csv print first 5 rows (yay pipe!)
cat arrays_table.csv | head -5

# parse table columns into 3 arrays
column_0=($(cut -d "," -f 1 $csv_file_conts))
column_1=($(cut -d "," -f 2 $csv_file_conts))
column_2=($(cut -d "," -f 3 $csv_file_conts))
# print first array
echo "Displaying the first column:"
echo "${column_0[@]}"