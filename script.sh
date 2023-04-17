#!/bin/bash

# Verifica se o usuário tem permissão de superusuário
if [[ $EUID -ne 0 ]]; then
  echo "Este script deve ser executado como root ou com permissão sudo"
  exit 1
fi





echo "Atualizando repositório e fazendo atualização do sistema"
apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}
apt_update


# Verifica se o gdebi esta instalado
if [ $(dpkg-query -W -f='${Status}' gdebi-core 2>/dev/null | grep -c "ok installed") -eq 1 ];
then
    echo "GDEBI já está instalado"
else
    # Install gdebi-core
    echo "Installing gdebi-core..."
    sudo apt-get update
    sudo apt-get install -y gdebi-core
fi




# Verifica se o snap esta instalado
if ! command -v snap &> /dev/null
then
    echo "Instalando snapd..."
    sudo apt-get update
    sudo apt-get install snapd -y
else
    echo "Snap já está instalado"
fi




# Verifica se o curl já está instalado
if ! command -v curl &> /dev/null
then
    echo "curl não encontrado, iniciando instalação..."
    # Instala o curl usando o APT
    sudo apt update
    sudo apt install curl -y

    # Verifica a versão instalada
    echo "curl instalado com sucesso na versão:"
    curl --version | head -n 1
else
    echo "CURL já está instalado"
fi




# Verificar se o git já está instalado
if [ -x "$(command -v git)" ]; then
  echo "GIT já está instalado"
else
  # Instalar o git
  sudo apt-get update
  sudo apt-get install git
fi




# Verificar se o Zoom já está instalado
if [ -x "$(command -v zoom)" ]; then
  echo "ZOOM já está instalado"
else
  # Instalar o Zoom
  wget https://zoom.us/client/5.14.2.2046/zoom_amd64.deb
  sudo gdebi -n zoom_amd64.deb
  rm zoom_amd64.deb
fi




# Instalação do venv
if ! [ -x "$(command -v python3 -m venv)" ]; then
    echo "Instalando o venv..."
    sudo apt install python3-venv -y
    echo "Venv instalado com sucesso"
    dpkg-query --show --showformat='${Version}\n' python3-venv

else
    echo "VENV ja instalado"
fi




# Instalação do Slack
if snap list | grep -q "slack"; then
    echo "SLACK já está instalado."
else
    echo "Instalando o Slack..."
    sudo snap install slack
fi




#verifica se o Spotify esta instalado
if ! [ -x "$(command -v spotify)" ]; then
    echo "Instalando Spotify..."
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt-get update && sudo apt-get install spotify-client -y
else
    echo "SPOTIFY ja instalado"
fi




# Verifica se o Visual Studio Code está instalado
if ! command -v code &> /dev/null; then
  echo "Instalando Visual Studio Code..."
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.asc.gpg
  sudo install -o root -g root -m 644 microsoft.asc.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update
  sudo apt install -y code
  rm microsoft.asc.gpg
else
  echo "VSCODE já está instalado"
fi




# Verifica se o Google Chrome está instalado
if ! command -v google-chrome &> /dev/null; then
  echo "Instalando Google Chrome..."
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo dpkg -i google-chrome-stable_current_amd64.deb
  sudo apt --fix-broken install -y
  rm google-chrome-stable_current_amd64.deb
else
  echo "CHROME já está instalado"
fi




# Verifica se o Discord está instalado
if ! command -v discord &> /dev/null; then
  echo "Instalando Discord..."
  wget -O discord.deb "https://discord.com/api/download?platform=linux&format=deb"
  sudo dpkg -i discord.deb
  sudo apt --fix-broken install -y
  rm discord.deb
else
  echo "DISCORD já está instalado"
fi




# Verifica se o Node.js já está instalado
if ! command -v node &> /dev/null
then
    echo "Node.js não encontrado, iniciando instalação..."
    sudo apt-get remove libnode72:amd64
    curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - &&\
    sudo apt-get install -y nodejs

    # Verifica a versão instalada
    echo "Node.js instalado com sucesso na versão:"
    node -v
else
    echo "NODE já está instalado"
fi




# Verifica se o Docker já está instalado
if ! [ -x "$(command -v docker)" ]; then
    # Instala as dependências iniciais
    echo "Instalando as dependências iniciais..."
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Adiciona a chave pública do repositório Docker na máquina
    echo "Adicionando chave pública do repositório Docker..."
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

    # Adiciona o repositório remoto na lista do apt
    echo "Adicionando o repositório remoto Docker na lista do apt..."
    echo \
      "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
      | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Instala o Docker no Linux
    echo "Instalando o Docker no Linux..."
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    

    # Adiciona o usuário ao grupo do Docker
    echo "Adicionando o usuário atual ao grupo do Docker..."
    sudo groupadd docker
    sudo usermod -aG docker $USER
    newgrp docker

    # Inicie o Daemon do Docker
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker instalado com sucesso!"
else
    echo "DOCKER já está instalado!"
fi




# Verifica se o docker-compose já está instalado
if ! [ -x "$(command -v docker-compose)" ]; then
    # Instala as dependências iniciais
    echo "Instalando o docker-compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    echo "Docker-Compose instalado com sucesso!"
else
    echo "DOCKER-COMPOSE já está instalado!"
fi

# Verificar se o Yarn já está instalado
if [ -x "$(command -v yarn)" ]; then
  echo "Yarn já está instalado"
else
  # Adicionar o repositório Yarn
  npm install --global yarn
  echo "Yarn instalado com sucesso"
fi


echo "Todos os softwares foram instalados com sucesso!"


