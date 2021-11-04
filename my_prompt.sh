# pyenv
 export PATH="/home/leonam/.pyenv/bin:$PATH"
 eval "$(pyenv init -)"
 eval "$(pyenv virtualenv-init -)"

# Python Local
export PATH="$HOME/.poetry/bin/:$HOME/.local/bin/:$PATH"

# DirEnv
# eval "$(direnv hook bash)"

# Fzf Finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Alias
alias k=kubectl
alias v=nvim
alias g=git
alias tor="/opt/tor-browser_en-US/Browser/start-tor-browser -detach"

# Evitar que o vim trave no Ctrl-S
stty -ixon

#NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Customizar PS1
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1='${debian_chroot:+($debian_chroot)}\[\033[34m\]\u@\h \[\033[32m\]\w\[\033[33m\]$(parse_git_branch)\[\033[00m\]\n\$ '
unset color_prompt force_color_prompt

# Elixir: Iex History
export ERL_AFLAGS="-kernel shell_history enabled"

# Pastebin
# login: jedi_vim
# passwd: 6E6a#3Q9k5e%
