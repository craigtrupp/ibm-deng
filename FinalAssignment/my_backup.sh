#!/bin/sh

# Perform the backup of all databases using the mysqldump
# Store the output in the file all-databases-backup.sql
# In the /tmp directory, create a directory named after current date like YYYYMMDD. For example, 20210830
# Move the file all-databases-backup.sql to /tmp/mysqldumps/<current date>/ directory

# 

# Destination folder
DEST=/tmp/mysqldump/$(date +"%F")

# DETAILS TO connect to host and create iterable
HOSTNAME='8036ddaec23d'
USER='root@172.21.0.1'
# Mocked password value
PASS='MTQ1OC1jcmFpZ3Ry' 

DATABASES=$(mysql -h $HOSTNAME -u $USER -p$PASS -e "SHOW DATABASES;" | tr -d "| " | grep -v Database)

# Directory creation
[ ! -d $DEST ] && mkdir -p $DEST

for db in $DATABASES;
do
    FILE="${DEST}/$db.sql.gz"
    mysqldump --single-transaction --routines --quick -h $HOSTNAME -u $USER -p $PASS -B $db | gzip > "$FILE"
done