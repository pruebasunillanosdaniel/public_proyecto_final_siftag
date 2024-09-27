FROM node:latest AS build

RUN mkdir -p  /app/react_interface_proyectotesis
COPY bin/react_interface_proyectotesis  /app/react_interface_proyectotesis 
WORKDIR /app/react_interface_proyectotesis
RUN npm i 
RUN npm run build

FROM nginx:latest
RUN apt update
RUN apt install nano -y
RUN mkdir -p  /etc/nginx_config/ssl/

COPY  ./certif/*  /etc/nginx_config/ssl/
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