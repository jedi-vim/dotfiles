MY_USER=leonam

apt-get install \
    build-essential \
    git \
    curl \
    autojump \
    nodejs \
    zsh \
    fonts-powerline

# Oh-my-Zsh
chsh -s $(which zsh) $MY_USER
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# NerdFonts
# Ag Silver Search

# Neovim
NEOVIM_VERSION="0.8.2"
curl -LO https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage
mv nvim.appimage /home/$USER/.local/bin/nvim
chmod u+x /home/$USER/.local/bin/nvim
