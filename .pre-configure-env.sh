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
    libfuse2

# KubeCTL
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update \
&& apt-get install -y kubectl
