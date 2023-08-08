postgres=# CREATE USER backup_operator WITH password 'b_operator321';
CREATE ROLE
postgres=# CREATE ROLE backup;
CREATE ROLE
postgres=# GRANT CONNECT ON DATABASE tolldata to backup;
GRANT
postgres=# GRANT SELECT ON ALL TABLES IN SCHEMA toll to backup;
ERROR:  schema "toll" does not exist
postgres=# GRANT SELECT ON ALL TABLES IN SCHEMA toll TO backup;
ERROR:  schema "toll" does not exist
postgres=# \c tolldata
psql (15.2 (Ubuntu 15.2-1.pgdg18.04+1), server 13.2)
You are now connected to database "tolldata" as user "postgres".
tolldata=# GRANT SELECT ON ALL TABLES IN SCHEMA toll to backup;
GRANT
tolldata=# GRANT backup TO backup_operator;
GRANT ROLE
tolldata=# 







