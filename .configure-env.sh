MY_USER=$(whoami)

# Install general deps
apt-get update
apt-get install build-essential
    git \
    curl \
    autojump \
    nodejs \
    fonts-powerline \
    libxml2-dev \
    libxslt-dev \
    python-dev \
    libmemcached-dev \
    zlib1g-dev

# Kitty
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

# Oh-my-Zsh
chsh -s $(which zsh) $MY_USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# PowerLevel10K Zsh Theme 
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# NVM 
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# Neovim
NEOVIM_VERSION="0.8.2"
curl -LO https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage
mv nvim.appimage /home/$USER/.local/bin/nvim
chmod u+x /home/$USER/.local/bin/nvim
ln -s $USER/.nvim-$NEOVIM_VERSION/bin/nvim $USER/.local/bin/nvim-$NEOVIM_VERSION

# Install HomeBrew
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install \
    gnu-sed ripgrep the_silver_searcher \
    pyenv

# Symbolic links of files that must have been in ~
ln -s $HOME/.config/zshrc $HOME/.zshrc

