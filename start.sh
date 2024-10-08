#!/bin/bash

echo -e "endpoint="minio_server:9000" # servicio minio 
correo_usuario="danielsalga50@hotmail.es"    
password_usuario="aid573move841"    
server_host=http://golang_servicios:9091/ #servicio golang ip  
accessKeyID="admin" 
secretAccessKey="password"  
smtp_server=smtp-mail.outlook.com  
POSTGRES_USER=tesis 
POSTGRES_DB=diagrama  
POSTGRES_PASSWORD=unillanos   
server_java=http://pdf:8090/  
POSTGRES_HOST_HOST=base_datos   " > .env  

export Private_key=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
export username=pruebasunillanosdaniel
#echo -e "machine github.com login ${username} password ${Private_key}" >>  $HOME/.netrc 
#export GOPRIVATE=github.com/pruebasunillanosdaniel/*
cd bin/

if [ ! -d "formatos_proyecto_final" ] ; then
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/formatos_proyecto_final
else
        cd formatos_proyecto_final
        git pull https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/formatos_proyecto_final main
        cd ..
fi


if [ ! -d "Proyecto_final_tesis" ]; then 
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/Proyecto_final_tesis
else
        cd Proyecto_final_tesis
        git pull  https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/Proyecto_final_tesis main
        cd ..
fi


if [ ! -d "react_interface_proyectotesis" ];then
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/react_interface_proyectotesis
else
        cd react_interface_proyectotesis
        git pull  https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/react_interface_proyectotesis main
        cd ..
fi

if [ ! -d "pdf_server_spring" ] ;then
        git clone   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/pdf_server_spring
else
        cd pdf_server_spring
        git pull   https://${username}:${Private_key}@github.com/pruebasunillanosdaniel/pdf_server_spring main
        cd ..
fi

cd ../
pwd 
sudo docker compose down -v 
#sudo docker volume rm -a
sudo docker compose -f docker-compose.yml  up --build