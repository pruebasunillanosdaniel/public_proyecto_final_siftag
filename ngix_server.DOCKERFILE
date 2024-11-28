FROM node:latest AS build

RUN mkdir -p  /app/react_interface_proyectotesis
COPY bin/react_interface_proyectotesis  /app/react_interface_proyectotesis 
WORKDIR /app/react_interface_proyectotesis
ARG REACT_APP_HOST_IP_SERVER="https://localhost:8449/golang_servicios"
ARG REACT_APP_HOST_IP_ADDRESS="/react"
RUN npm i 
RUN npm run build

FROM nginx:latest
RUN apt update
RUN apt install nano -y
RUN mkdir -p  /etc/nginx_config/ssl/

COPY  ./certif/key.key  /etc/nginx_config/ssl/key.key
COPY  ./certif/cert.crt  /etc/nginx_config/ssl/cert.crt
COPY  ./certif/dhparam.pem /etc/nginx_config/ssl/dhparam.pem
RUN rm  /etc/nginx/conf.d/default.conf
COPY ./config/default.conf /etc/nginx/conf.d/default.conf
COPY ./config/signed.conf /etc/nginx_config/ssl/signed.conf
COPY ./config/ssl-params.conf  /etc/nginx_config/ssl/ssl-params.conf 

RUN mkdir -p  /usr/share/nginx/html/react
COPY --from=build /app/react_interface_proyectotesis/dist /usr/share/nginx/html/react
RUN mkdir -p  /usr/share/nginx/html/error
COPY ./assets/* /usr/share/nginx/html/error

EXPOSE 80
EXPOSE 443