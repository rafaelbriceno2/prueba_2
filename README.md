--INSTALACION IMAGEN--
Desinstalar versiones que generen conflicto en la cli 

!for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done!

