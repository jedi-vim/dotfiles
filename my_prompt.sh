# Alias
alias k=kubectl
alias v=nvim-0.6
alias g=git
alias tor="/opt/tor-browser_en-US/Browser/start-tor-browser -detach"

# pyenv
export PATH="/home/leonam/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Python Local
export PATH="$HOME/.poetry/bin/:$HOME/.local/bin/:$PATH"

# Fzf Finder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

# Golang
export PATH=$PATH:/usr/local/go/bin

# LuaRocks
export LUA_PATH='/usr/local/share/lua/5.1/?.lua;./?.lua;/home/linuxbrew/.linuxbrew/Cellar/luajit/2.0.5/share/luajit-2.0.5/?.lua;/usr/local/share/lua/5.1/?/init.lua;/home/linuxbrew/.linuxbrew/Cellar/luajit/2.0.5/share/lua/5.1/?.lua;/home/linuxbrew/.linuxbrew/Cellar/luajit/2.0.5/share/lua/5.1/?/init.lua;/home/leonam/.luarocks/share/lua/5.1/?.lua;/home/leonam/.luarocks/share/lua/5.1/?/init.lua'
export LUA_CPATH='./?.so;/usr/local/lib/lua/5.1/?.so;/home/linuxbrew/.linuxbrew/Cellar/luajit/2.0.5/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/home/leonam/.luarocks/lib/lua/5.1/?.so'
export PATH='/home/leonam/.luarocks/bin:/home/leonam/.pyenv/plugins/pyenv-virtualenv/shims:/home/leonam/.pyenv/shims:/home/leonam/.nvm/versions/node/v14.15.0/bin:/home/leonam/.poetry/bin/:/home/leonam/.local/bin/:/home/leonam/.pyenv/bin:/home/leonam/bin:/usr/local/bin:/home/leonam/.local/bin:/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/leonam/.poetry/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/snap/bin:/usr/local/go/bin'
