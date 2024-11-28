FROM alpine:latest
RUN  set -eux;\ 	
	apk add --no-cache  openjdk17-jdk 
RUN  set -eux;\ 	
	apk add  --no-cache   bash;
RUN set -eux;\ 
	apk add --no-cache    maven;
RUN set -eux;\
	apk add --no-cache   font-noto font-noto-cjk  ; 
RUN java --version
RUN ls -a /usr/share/java/maven-3/bin
ENV PATH=/usr/share/java/maven-3/bin:$PATH
ENV PATH=$PATH:/usr/java/latest/bin


#FROM maven:3.9.9-eclipse-temurin-17 AS  build

RUN mkdir /app
COPY bin/pdf_server_spring /app/pdf_server_spring

WORKDIR /app
 


WORKDIR /app/pdf_server_spring
 

 

# Compilar la clase en un archivo jar
RUN mvn clean install -e            
# Copiar las dependencias a una carpeta
RUN  mvn dependency:copy-dependencies 
 
 

EXPOSE 8090
#ejecutar la 
 
ENTRYPOINT ["java","-cp","target/dependency/*:target/Pdf_sistema-0.1.0.jar" , "main.Main"]
 

