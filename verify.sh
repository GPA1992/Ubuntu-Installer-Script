#!/bin/bash

# Verifica se o gdebi-core está instalado
if [ $(dpkg-query -W -f='${Status}' gdebi-core 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "gdebi-core: ✔️ $(dpkg-query -W -f='${Version}' gdebi-core)"
else
    echo "gdebi-core: ❌ não instalado"
fi

# Verifica se o Zoom está instalado
if [ $(dpkg-query -W -f='${Status}' zoom 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "Zoom: ✔️ $(dpkg-query -W -f='${Version}' zoom)"
else
    echo "Zoom: ❌ não instalado"
fi

# Verifica se o snapd está instalado
if [ -x "$(command -v snap)" ]; then
    echo "snapd: ✔️ $(snap version | awk '/snapd/ {print $2}')"
else
    echo "snapd: ❌ não instalado"
fi

# Verifica se o Slack está instalado
if [ -x "$(command -v slack)" ]; then
    echo "Slack: ✔️  Na versão mais recente"
else
    echo "Slack: ❌ não instalado"
fi

# Verifica se o Visual Studio Code está instalado
if [ $(dpkg-query -W -f='${Status}' code 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "Visual Studio Code: ✔️ $(dpkg-query -W -f='${Version}' code)"
else
    echo "Visual Studio Code: ❌ não instalado"
fi

# Verifica se o Google Chrome está instalado
if [ $(dpkg-query -W -f='${Status}' google-chrome-stable 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "Google Chrome: ✔️ $(dpkg-query -W -f='${Version}' google-chrome-stable)"
else
    echo "Google Chrome: ❌ não instalado"
fi

# Verifica se o Discord está instalado
if [ $(dpkg-query -W -f='${Status}' discord 2>/dev/null | grep -c "ok installed") -eq 1 ]; then
    echo "Discord: ✔️ $(dpkg-query -W -f='${Version}' discord)"
else
    echo "Discord: ❌ não instalado"
fi

# Verifica se o Node.js está instalado
if [ -x "$(command -v node)" ]; then
    echo "Node.js: ✔️ $(node -v)"
else
    echo "Node.js: ❌ não instalado"
fi

# Verifica se o programa Docker está instalado
if [ -x "$(command -v docker)" ]; then
    echo "Docker: ✔️ $(docker --version | awk '{print $3}')"
else
    echo "Docker: ❌ não instalado"
fi

# Verifica se o programa Docker Compose está instalado
if [ -x "$(command -v docker-compose)" ]; then
    echo "Docker Compose: ✔️ $(docker-compose --version | awk '{print $3}')"
else
    echo "Docker Compose: ❌ não instalado"
fi


# Verifica se o venv esta instalado
if [ -x "$(command -v python3 -m venv)" ]; then
    echo "Venv: ✔️ $(dpkg-query --show --showformat='${Version}\n' python3-venv)"      
else
    echo "Venv: ❌ não instalado"
fi