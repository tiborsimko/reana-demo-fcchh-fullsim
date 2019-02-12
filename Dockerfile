FROM ubuntu:18.04
RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y; \
    apt install -y wget gnupg;
RUN wget -q  https://fcc-pileup.web.cern.ch/fcc-pileup/sw/latest/x86_64-ubuntu1804-gcc8-opt/keyFile; \ 
    apt-key add keyFile; \ 
    rm keyFile; \
    wget https://fcc-pileup.web.cern.ch/fcc-pileup/sw/latest/x86_64-ubuntu1804-gcc8-opt/hep-fccrepoconfig_0.0-3.deb; \
    dpkg -i hep-fccrepoconfig_0.0-3.deb; \
    rm hep-fccrepoconfig_0.0-3.deb; \
    apt update; \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y; \
    apt install -y hep-fccsw;
RUN apt install -y hep-geant4data;
