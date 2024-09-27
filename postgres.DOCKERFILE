FROM postgres:latest

COPY ./config/init.sql /docker-entrypoint-initdb.d/
#COPY ./config/init_db.sh /docker-entrypoint-initdb.d/

EXPOSE 5432

