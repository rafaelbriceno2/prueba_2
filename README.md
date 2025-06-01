#INSTALACION IMAGEN

#Desinstalar versiones que generen conflicto en la cli 

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

Agrega los repositorios para instalar el docker, puedes tomar los comandos del siguiente enlace:
https://docs.docker.com/engine/install/ubuntu/

 #instala git en la maquina

**Actualiza repo**

´sudo apt update´

**Instala git** 

sudo apt install git 

git --version 

**Haz un git clone**

git clone https://github.com/rafaelbriceno2/prueba_2.git

**ejecuta el siguiente comando para construir la imagen.**

docker build -t docker-nagios





