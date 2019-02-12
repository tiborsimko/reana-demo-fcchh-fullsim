FROM ubuntu:18.04
# tools needed to setup repository
RUN apt update; \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y; \
    apt install -y wget gnupg;
# setup of the fcc apt repository
RUN wget -q  https://fcc-pileup.web.cern.ch/fcc-pileup/sw/latest/x86_64-ubuntu1804-gcc8-opt/keyFile; \ 
    apt-key add keyFile; \ 
    rm keyFile; \
    wget https://fcc-pileup.web.cern.ch/fcc-pileup/sw/latest/x86_64-ubuntu1804-gcc8-opt/hep-fccrepoconfig_0.0-3.deb; \
    dpkg -i hep-fccrepoconfig_0.0-3.deb; \
    rm hep-fccrepoconfig_0.0-3.deb; \
    apt update; \
    DEBIAN_FRONTEND=noninteractive apt upgrade -y; \
    apt install -y hep-fccsw;
# download data files needed to run geant4
RUN apt install -y hep-geant4data;
## necessary shell environment (usually sourced from /etc/profile)
ENV G4NEUTRONHPDATA=/usr/local/share/Geant4/data/G4NDL4.5 \
    G4LEDATA=/usr/local/share/Geant4/data/G4EMLOW7.7 \
    G4LEVELGAMMADATA=/usr/local/share/Geant4/data/PhotonEvaporation5.3 \
    G4RADIOACTIVEDATA=/usr/local/share/Geant4/data/RadioactiveDecay5.3 \
    G4NEUTRONXSDATA=/usr/local/share/Geant4/data/G4NEUTRONXS1.4 \
    G4PIIDATA=/usr/local/share/Geant4/data/G4PII1.3 \
    G4REALSURFACEDATA=/usr/local/share/Geant4/data/RealSurface2.1.1 \
    G4SAIDXSDATA=/usr/local/share/Geant4/data/G4SAIDDATA2.0 \
    G4ABLADATA=/usr/local/share/Geant4/data/G4ABLA3.1 \
    G4ENSDFSTATEDATA=/usr/local/share/Geant4/data/G4ENSDFSTATE2.2 \
    PYTHIA8_DIR=/usr/local \
    PYTHIA8_XML=$PYTHIA8_DIR/share/Pythia8/xmldoc \
    PYTHIA8DATA=$PYTHIA8_XML \
    HEPMC_PREFIX=$PYTHIA8_DIR \
    DD4hepINSTALL=/usr/local/ \
    DD4hep_DIR=/usr/local/ \
    DD4hep_ROOT=/usr/local/ \
    DD4HEP_LIBRARY_PATH=$/usr/local/lib/ \
    ROOT_INCLUDE_PATH=$ROOT_INCLUDE_PATH:/usr/local/include:/usr/local/include/datamodel \
    PYTHONPATH=$PYTHONPATH:/usr/local/lib:/usr/local/python \
    PATH=$PATH:/usr/local/scripts/:/usr/local/bin \
    CPLUS_INCLUDE_DIR=$CPLUS_INCLUDE_DIR:/usr/local/include \
    GAUDI_LIBRARY_PATH=/usr/local/lib \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

