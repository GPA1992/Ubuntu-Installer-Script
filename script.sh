#!/bin/bash

# Verifica se o usuário tem permissão de superusuário
if [[ $EUID -ne 0 ]]; then
  echo "Este script deve ser executado como root ou com permissão sudo"
  exit 1
fi





echo "Atualizando repositório e fazendo atualização do sistema"
apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
  wait
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
    wait
    echo "|------------------------------------------------------------|"
    echo "GDEBI instalado"
fi








# Verifica se o curl já está instalado
if ! command -v curl &> /dev/null
then
    echo "curl não encontrado, iniciando instalação..."
    # Instala o curl usando o APT
    sudo apt update
    sudo apt install curl -y

    # Verifica a versão instalada
    wait
    echo "|------------------------------------------------------------|"
    echo "curl instalado com sucesso"
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
  wait
  echo "|------------------------------------------------------------|"
  echo "git instalado com sucesso"
fi




# Instalação do Python
if ! [ -x "$(command -v python3)" ]; then
  echo "Instalando o python..."
  sudo apt install python3 -y
  sudo apt install python3-venv -y    
  wait
  echo "|------------------------------------------------------------|"
  echo "PYTHON instalado com sucesso"


else
    echo "PYTHON ja instalado"
fi




# Instalação do Slack
if snap list | grep -q "slack"; then
    echo "SLACK já está instalado."
else
    echo "Instalando o Slack..."
    sudo snap install slack
  wait
  echo "|------------------------------------------------------------|"
  echo "SLACK instalado com sucesso"

fi




#verifica se o Spotify esta instalado
if ! [ -x "$(command -v spotify)" ]; then
  echo "Instalando Spotify..."
  curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update && sudo apt-get install spotify-client -y
  wait
  echo "|------------------------------------------------------------|"
  echo "Spotify instalado com sucesso"

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
  wait
  echo "|------------------------------------------------------------|"
  echo "VSCODE instalado com sucesso"
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
  wait
  echo "|------------------------------------------------------------|"
  echo "CHROME instalado com sucesso"

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
  wait
  echo "|------------------------------------------------------------|"
  echo "DISCORD instalado com sucesso"

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
  wait
  echo "|------------------------------------------------------------|"
  echo "NODE instalado com sucesso"

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
  wait
  echo "|------------------------------------------------------------|"
  echo "DOCKER instalado com sucesso"

else
    echo "DOCKER já está instalado!"
fi




# Verifica se o docker-compose já está instalado
if ! [ -x "$(command -v docker-compose)" ]; then
    # Instala as dependências iniciais
    echo "Instalando o docker-compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

  wait
  echo "|------------------------------------------------------------|"
  echo "DOCKER-COMPOSE instalado com sucesso"

else
    echo "DOCKER-COMPOSE já está instalado!"
fi

# Verificar se o Yarn já está instalado
if [ -x "$(command -v yarn)" ]; then
  echo "Yarn já está instalado"
else
  # Adicionar o repositório Yarn
  npm install --global yarn
  wait
  echo "|------------------------------------------------------------|"
  echo "YARN instalado com sucesso"

fi


echo "Todos os softwares foram instalados com sucesso!"


