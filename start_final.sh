#!/bin/bash


#echo -e "endpoint="minio-server:9000" # servicio minio 
#correo_usuario="solrevisdor143@gmail.com"    
#password_usuario="zylelzuzavmruvwa"    
#server_host=http://localhost:8082/golang_servicio/ #servicio golang ip  
#accessKeyID="admin" 
#secretAccessKey="password"  
#MINIO_ROOT_USER="admin"
#MINIO_ROOT_PASSWORD="password" 
#smtp_server=smtp.gmail.com 
#POSTGRES_USER=tesis 
#POSTGRES_DB=diagrama  
#POSTGRES_PASSWORD=unillanos   
#server_java=http://pdf:8090/  
#POSTGRES_HOST_HOST=base_datos 
#REACT_APP_HOST_IP_SERVER=http://10.1.5.145/golang_servicio
#REACT_APP_HOST_IP_ADDRESS=http://10.1.5.145/react
#  " > .env  

export Private_key=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

export accessKeyID="admin" 
export secretAccessKey="password"  
echo $Private_key
export username=pruebasunillanosdaniel
 
export c=$PWD
mkdir -p bin/
cd bin
echo -e  "1 $PWD"
if [ ! -d "formatos_proyecto_final" ] ; then
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/formatos_proyecto_final
else
        cd formatos_proyecto_final
        git pull https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/formatos_proyecto_final main
        cd ..
fi
echo -e  "2 $PWD"



if [ ! -d "Proyecto_final_tesis" ]; then 
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/Proyecto_final_tesis
else
        cd Proyecto_final_tesis
        git pull  https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/Proyecto_final_tesis main
        cd ..
fi

echo -e  "3 $PWD"

if [ ! -d "react_interface_proyectotesis" ];then
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/react_interface_proyectotesis
else
        cd react_interface_proyectotesis
        git pull  https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/react_interface_proyectotesis main
        cd ..
fi

echo -e  "4 $PWD"
if [ ! -d "pdf_server_spring" ] ;then
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/pdf_server_spring
else
         cd  pdf_server_spring
        git pull   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/pdf_server_spring main
        cd ..
fi
echo -e  "5 "$c"/certif"
if [ ! -d $c"/certif" ] ;then
        cd $c
        echo  -e "creando certificado"
        mkdir -p certif
        cd certif/
        sudo openssl dhparam -out dhparam.pem 4096
        sudo openssl req -trustout -x509 -newkey rsa:2048 -sha256 -nodes -keyout key.key -out cert.crt -days 3650
          cd ..
fi

cd $c

pwd 
sudo docker compose kill
sudo docker compose down -v 
#sudo docker volume rm -a
#export BUILDKIT_PROGRESS=plain

 docker compose -f ./docker-compose.yml  up   --build  --force-recreate --remove-orphans


 #sudo   docker compose build  --env-file ./enviroments/test/prod.env 
 #sudo   docker compose   -f ./docker-compose.yml   up    --build     --force-recreate --remove-orphans 

#podman run -p 9000:9000 -p 9001:9001 \
 # quay.io/minio/minio server /data --console-address ":9001"

#sudo  docker build    -e MINIO_ROOT_USER=admin -e  MINIO_ROOT_PASSWORD=password   -f minio.DOCKERFILE .
#export 