#!/bin/bash

# Verifica se o gdebi-core está instalado
if [ $(dpkg-query -W -f='${Status}' gdebi-core 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "GDEBI-CORE: ✔️ $(dpkg-query -W -f='${Version}' gdebi-core)"
else
    echo "GDEBI-CORE: ❌ não instalado"
fi

# Verifica se o Zoom está instalado
if [ $(dpkg-query -W -f='${Status}' zoom 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "ZOOM: ✔️ $(dpkg-query -W -f='${Version}' zoom)"
else
    echo "ZOOM: ❌ não instalado"
fi

# Verifica se o snapd está instalado
if [ -x "$(command -v snap)" ]; then
    echo "SNAP: ✔️ $(snap version | awk '/snapd/ {print $2}')"
else
    echo "SNAP: ❌ não instalado"
fi

# Verifica se o Slack está instalado
if [ -x "$(command -v slack)" ]; then
    echo "SLACK: ✔️  Na versão mais recente"
else
    echo "SLACK: ❌ não instalado"
fi

# Verifica se o Visual Studio Code está instalado
if [ $(dpkg-query -W -f='${Status}' code 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "VSCODE: ✔️ $(dpkg-query -W -f='${Version}' code)"
else
    echo "VSCODE: ❌ não instalado"
fi

# Verifica se o Google Chrome está instalado
if [ $(dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "GOOGLE CHROME: ✔️ $(dpkg-query -W -f='${Version}' google-chrome-stable)"
else
    echo "GOOGLE CHROME: ❌ não instalado"
fi

# Verifica se o Discord está instalado
if [ $(dpkg-query -W -f='${Status}' discord 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "DISCORD: ✔️ $(dpkg-query -W -f='${Version}' discord)"
else
    echo "DISCORD: ❌ não instalado"
fi

# Verifica se o Node.js está instalado
if [ -x "$(command -v node)" ]; then
    echo "NODE.JS: ✔️ $(node -v)"
else
    echo "NODE.JS: ❌ não instalado"
fi

# Verifica se o programa Docker está instalado
if [ -x "$(command -v docker)" ]; then
    echo "DOCKER: ✔️ $(docker --version | awk '{print $3}')"
else
    echo "DOCKER: ❌ não instalado"
fi

# Verifica se o programa Docker Compose está instalado
if [ -x "$(command -v docker-compose)" ]; then
    echo "DOCKER COMPOSE: ✔️ $(docker-compose --version | awk '{print $3}')"
else
    echo "DOCKER COMPOSE: ❌ não instalado"
fi


# Verifica se o venv esta instalado
if [ -x "$(command -v python3 -m venv)" ]; then
    echo "VENV: ✔️ $(dpkg-query --show --showformat='${Version}\n' python3-venv)"      
else
    echo "VENV: ❌ não instalado"
fi

#verifica se o Spotify esta instalado
if [ -x "$(command -v spotify)" ]; then
   echo "Spotify: ✔️ $(dpkg -l spotify-client | grep spotify-client | awk '{print $3}')" 
else
    echo "SPOTIFY: ❌ não instalado"
fi


#verifica se o CURL esta instalado
if [ -x "$(command -v curl)" ]; then
    echo "CURL: ✔️ $(curl --version | awk 'NR==1{print $2}')"
else
    echo "CURL: ❌ não instalado"
fi

# Verificar se o git já está instalado
if [ -x "$(command -v git)" ]; then
  echo "GIT: ✔️ $(git --version)"
else
  echo "GIT: ❌ não instalado"
fi


# Verificar se o Yarn já está instalado
if [ -x "$(command -v yarn)" ]; then
  echo "YARN: ✔️ $(yarn --version)"
else
  echo "YARN: ❌ não instalado"
fi