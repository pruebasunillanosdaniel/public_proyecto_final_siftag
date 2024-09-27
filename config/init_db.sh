
#!/bin/bash

set -e
set -u

echo "  Creating user and database "


psql <<-EOSQL
	    
	IF NOT EXISTS (
      SELECT FROM pg_catalog.pg_roles
      WHERE  rolname = 'tesis') THEN
      CREATE USER tesis with password 'unillanos';
   END IF;   
EOSQL        


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    
	    CREATE DATABASE diagrama;
	    GRANT ALL PRIVILEGES ON DATABASE diagrama TO $POSTGRES_USER;
EOSQL        

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE DATABASE fiber;
	    GRANT ALL PRIVILEGES ON DATABASE diagrama TO $POSTGRES_USER;
EOSQL