FROM debian:stable-slim
# crea variables 
ENV MINIO_ROOT_USER=admin 
ENV MINIO_ROOT_PASSWORD=password
 
#actualiza dependecias necesarias
RUN apt update
RUN apt install  wget -y
#crear carpetas necesarias
RUN mkdir /tmp/files
RUN mkdir -p /usr/bin/minio 
RUN mkdir -p /usr/data/minio

#descarga minio y mc 
WORKDIR /usr/bin/minio 
RUN wget https://dl.min.io/server/minio/release/linux-amd64/minio
RUN chmod +x minio
RUN wget https://dl.min.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc
#remover apt
RUN apt remove  wget -y
# exponer puerto necesarios
EXPOSE 9000
EXPOSE 9001
# llenar el repositorio de  minio 
COPY ./bin/formatos_proyecto_final /tmp/files 
RUN /usr/bin/minio/mc mb formatosdocumento
RUN /usr/bin/minio/mc cp --recursive  /tmp/files  formatos
#ejecutar proceso
WORKDIR /usr/bin/minio 
ENTRYPOINT ["./minio"]
CMD ["server", "/usr/data/minio --console-address:9001 " ]
