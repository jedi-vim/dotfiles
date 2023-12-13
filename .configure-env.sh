echo "\n\n###### Oh-my-Zsh #############"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k && \
rm $HOME/.zshrc && ln -s $HOME/.config/zshrc $HOME/.zshrc

echo "\n\n####### Install HomeBrew ######"
git clone https://github.com/Homebrew/brew
export PATH=$HOME/brew/bin:$PATH
brew install gnu-sed ripgrep the_silver_searcher pyenv

echo "\n\n####### Kitty ################"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

echo "\n\n######### Installing NVM $=#####"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

echo "\n\n########## Neovim ##############"
NEOVIM_VERSION="0.8.1"
curl -LO https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage
mkdir -p $HOME/.local/bin/ && mv nvim.appimage $HOME/.local/bin/nvim && chmod u+x $HOME/.local/bin/nvim
ln -s $HOME/.local/bin/nvim $HOME/.local/bin/nvim-$NEOVIM_VERSION
