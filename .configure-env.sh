echo "\n\n###### Oh-my-Zsh #############"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended && \
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k && \
rm $HOME/.zshrc && ln -s $HOME/.config/zshrc $HOME/.zshrc

echo "\n\n###### Nerd Font #############"
wget -P $HOME/.local/share/fonts/ https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Meslo/L/Regular/MesloLGLNerdFont-Regular.ttf
wget -P $HOME/.local/share/fonts/ https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/ComicShannsMono/ComicShannsMonoNerdFont-Regular.otf

echo "\n\n####### Install HomeBrew ######"
git clone https://github.com/Homebrew/brew
export PATH=$HOME/brew/bin:$PATH
brew install gnu-sed ripgrep the_silver_searcher pyenv

echo "\n\n####### Kitty ################"
curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
# Update the paths to the kitty and its icon in the kitty.desktop file(s)
sed -i "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
sed -i "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop

echo "\n\n######### Installing NVM $=#####"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

echo "\n\n########## Neovim ##############"
NEOVIM_VERSION="0.8.1"
curl -LO https://github.com/neovim/neovim/releases/download/v$NEOVIM_VERSION/nvim.appimage
mkdir -p $HOME/.local/bin/ && mv nvim.appimage $HOME/.local/bin/nvim && chmod u+x $HOME/.local/bin/nvim
ln -s $HOME/.local/bin/nvim $HOME/.local/bin/nvim-$NEOVIM_VERSION
