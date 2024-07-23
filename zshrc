# Alias
alias k=kubectl
alias v=nvim-0.8.1
alias g=git

export BASH_VERSION=$(zsh --version)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"

# HomeBrew
export PATH=$HOME/brew/bin:$PATH

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    autojump
    # zsh-autosuggestions
    # zsh-syntax-highlighting
)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# pyenv
export PATH="/home/leonam/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Python Local
export PATH="$HOME/.poetry/bin/:$HOME/.local/bin/:$PATH"

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Elixir: Iex History
export ERL_AFLAGS="-kernel shell_history enabled"

# Golang
export PATH=$PATH:/usr/local/go/bin

# Kitty
export PATH=$PATH:$HOME/.local/kitty.app/bin/
export KITTY_CONFIG_DIRECTORY=$HOME/.config/kitty

source $ZSH/oh-my-zsh.sh
