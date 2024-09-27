FROM node:latest  

RUN mkdir -p  /app/react_interface_proyectotesis
COPY bin/react_interface_proyectotesis  /app/react_interface_proyectotesis 
WORKDIR /app/react_interface_proyectotesis
RUN npm i 
RUN npm run build
