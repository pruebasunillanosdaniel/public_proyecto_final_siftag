FROM golang:alpine AS build

RUN mkdir /app
WORKDIR /app
COPY bin/Proyecto_final_tesis /app/Proyecto_final_tesis
WORKDIR /app/Proyecto_final_tesis


ENV  Private_key=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
ENV   username=pruebasunillanosdaniel
ENV GOPRIVATE=github.com/pruebasunillanosdaniel/*
ENV basededatos=base_datos

RUN echo -e "machine github.com login ${username} password ${Private_key}" >>  $HOME/.netrc 
RUN   set -eux;\
         apk --no-cache  add git 
#RUN  set -eux;\
#        go mod tidy
RUN echo -e "module Logica_negocio \n go 1.22 \n toolchain go1.22.1" > go.mod
RUN   set -eux;\
          go mod tidy ;
RUN mkdir /build
RUN   go build -o /build/main .
#RUN   go build -o /build/main .
#RUN echo -e "" >  $HOME/.netrc
#RUN echo -e "" >  /build/main

FROM golang:alpine 
#FROM scratch
RUN mkdir /app
COPY --from=0 /build /app/Proyecto_final_tesis

WORKDIR /app/Proyecto_final_tesis
RUN chmod +x main
#para la comprobacion de si el servicio funciona
RUN   set -eux;\ 
         apk  add curl  
        
EXPOSE 9091
CMD ["./main"]


