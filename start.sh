#!/bin/bash
 

export Private_key=XXXXX
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
echo -e  $c"/certif"
if [ ! -d $c"/certif" ] ;then
        cd $c
        echo  -e "creando certificado"
        mkdir -p certif
        cd certif/
        sudo openssl req -trustout -x509 -newkey rsa:2048 -sha256 -nodes -keyout key.key -out cert.crt -days 3650
	sudo openssl dhparam -out dhparam.pem 4096
        cd ..
fi

cd $c

cat enviroments/golang.env | awk '{print $0"\n"}' | tee -a .env;
cat enviroments/minio.env |awk '{print $1"\n"}' | tee -a .env;
cat enviroments/postgres.env | awk '{print $1"\n"}' |tee -a .env;
cat enviroments/react.env |awk '{print $1"\n"}' | tee -a .env;


pwd 
sudo docker compose kill
sudo docker compose down -v 
#sudo docker volume rm -a
export BUILDKIT_PROGRESS=plain
 sudo docker compose build --build-arg Private_key=${Private_key}
   sudo docker compose -f ./docker-compose.yml  up     --force-recreate --remove-orphans