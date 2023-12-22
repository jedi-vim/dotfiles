# Install general deps
apt-get update
apt-get -y \
    install build-essential \
    dialog \
    git \
    curl \
    autojump \
    nodejs \
    fonts-powerline \
    libxml2-dev \
    libxslt-dev \
    python-dev \
    libmemcached-dev \
    zlib1g-dev \
    htop \
    zsh \
    apt-transport-https \
    ca-certificates \
    software-properties-common

# KubeCTL
dialog --title "Aguarde" \
    --infobox "Instalando Docker KubeCTL"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubectl

# Docker
dialog --title "Aguarde" \
    --infobox "Instalando Docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
    sudo apt update && \
    apt-get install -y docker-ce
USER_NAME=$(dialog --inputbox 'Usuario que vai usar o docker:' 0 0  2> /dev/null)
usermod -aG docker ${USER_NAME}

# Docker Compose
dialog --title "Aguarde" \ 
    --infobox "Instalando Docker-Compose"
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Golang
dialog --title "Aguarde" \
    --infobox "Instalando GoLang"
curl -s -L https://go.dev/dl/go1.21.4.linux-amd64.tar.gz | tar xzv -C /usr/local

