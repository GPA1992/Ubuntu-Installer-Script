## Unbuntu Installer Script

Este repositório contém dois arquivos úteis para quem precisa instalar softwares em uma nova instalação do sistema operacional Debian. O arquivo script.sh é responsável por atualizar o sistema e instalar uma lista de softwares pré-definidos, enquanto o arquivo verify.sh verifica se os softwares foram instalados corretamente.

### Como usar

Antes de executar os scripts é necessário permitir que eles sejam executados.

`chmod +x script.sh`

`chmod +x verify.sh`

Em seguida, é possivel executar o script:

`sudo ./script.sh`

ou

`sudo ./verify.sh`

### Lista de Softwares e pacotes

- gdebi
- zoom
- snap
- slack
- VScode
- Google Chrome
- Discord
- Nodejs
- Docker
- Docker-Compose
- Venv

### Aviso

Este script foi testado apenas em sistemas operacionais Debian. É recomendável fazer backup de seus dados antes de executar o script. O autor do script não se responsabiliza por quaisquer danos causados ao sistema. Use por sua própria conta e risco.

#### Fique a vontade para criar uma branch e contribuir com o repositório
