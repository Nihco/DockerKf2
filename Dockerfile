# Usar una imagen base de Ubuntu
FROM ubuntu:20.04

# Actualizar y preparar el entorno
RUN apt-get update && \
    apt-get install -y wget curl unzip lib32gcc1 && \
    useradd -m steam && \
    mkdir -p /home/steam/kf2server

# Cambiar al usuario steam
USER steam
WORKDIR /home/steam

# Descargar SteamCMD
RUN mkdir -p /home/steam/steamcmd && \
    cd /home/steam/steamcmd && \
    wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz && \
    tar -xvzf steamcmd_linux.tar.gz && \
    rm steamcmd_linux.tar.gz

# Instalar y actualizar Killing Floor 2 usando los comandos de la guía
RUN /home/steam/steamcmd/steamcmd.sh +force_install_dir /home/steam/kf2server +login anonymous +app_update 232130 validate +quit

# Exponer los puertos necesarios
EXPOSE 7777/udp 27015/udp

# Comando para iniciar el servidor
ENTRYPOINT ["/home/steam/kf2server/Binaries/Win64/KFServer.exe", "KF-BioticsLab"]
