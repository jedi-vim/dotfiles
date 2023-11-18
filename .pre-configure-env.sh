# Install general deps
apt-get update
apt-get -y \
    install build-essential \
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
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubectl

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && \
    sudo apt update && \
    apt-get install -y docker-ce
# TODO: Depois de instalar preciso colocar meu usuario no grupo docker: usermod -aG docker ${USER}

# Golang
curl -s -L https://go.dev/dl/go1.21.4.linux-amd64.tar.gz | tar xzv -C /usr/local

