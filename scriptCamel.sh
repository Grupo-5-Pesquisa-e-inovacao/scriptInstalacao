#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

# Verifica se o Java está instalado
java -version
if [ $? = 0 ]; then
    echo "Java Instalado!"
else
    echo "Não possui Java"
    sudo apt install -y openjdk-17-jre
fi

# Instala o Docker
if ! command -v docker &> /dev/null; then
    echo "Instalando Docker..."
    sudo apt-get update
    sudo apt-get install -y docker.io
    sudo usermod -aG docker $USER
    echo "Docker instalado com sucesso."
else
    echo "Docker já está instalado."
fi

sudo usermod -aG docker $USER
sudo docker build -t bancocamel .

sudo docker run -d --name containerCamel -p 3306:3306 bancocamel


REPO_NAME="Sprint3"
GITHUB_URL="https://github.com/Grupo-5-Pesquisa-e-inovacao/Sprint3.git"


if [ -d "$REPO_NAME" ]; then
    echo "O repositório $REPO_NAME já existe. Atualizando..."
    cd $REPO_NAME
    git pull

    java -jar apiCamelLooca.jar


else
    echo "Clonando o repositório $REPO_NAME do GitHub..."
    git clone $GITHUB_URL
    cd $REPO_NAME

     java -jar apiCamelLooca.jar

fi



echo "Instalação concluída."
