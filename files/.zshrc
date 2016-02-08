# https://github.com/robbyrussell/oh-my-zsh

ZSH=$HOME/.oh-my-zsh

ZSH_THEME="blinks"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
#COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(composer emacs extract npm nvm pip rbenv stack vi-mode)

source $ZSH/oh-my-zsh.sh

############################
# Customize to your needs...
############################


HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

autoload -Uz compinit
autoload zkbd
autoload colors; colors
compinit

export LANG=ru_RU.UTF-8


setopt appendhistory sharehistory hist_verify hist_ignore_all_dups hist_expire_dups_first hist_find_no_dups hist_ignore_space hist_reduce_blanks 
setopt extendedglob

setopt auto_cd correct_all

export CLICOLOR="xterm-color"
export LS_OPTIONS='--color=auto'
export ZLS_COLORS=LS_COLORS
eval "`dircolors`"
export VISUAL=vim
#export EDITOR="gvim --remote-tab-silent"
export EDITOR='setsid emacsclient "$@" -a ""'
export TERM=xterm-256color
export PAGER=less
[[ $EMACS = t ]] && unsetopt zle

setopt MENUCOMPLETE
setopt complete_in_word
setopt AUTO_LIST
setopt AUTO_MENU
setopt LONG_LIST_JOBS
setopt AUTO_PARAM_SLASH

setopt ALL_EXPORT

unsetopt beep notify
bindkey -v

zmodload -i zsh/complist
zmodload zsh/mathfunc

source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh

alias :r="source ~/.zshrc" 
alias :q="exit"
alias apt="sudo aptitude"
alias cls="clear"
alias emacs='setsid emacsclient "$@" -a ""'
alias ls='ls --group-directories-first $LS_OPTIONS -1 --ignore="*.pyc"'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias rm='rm -i'
alias docker='sudo docker'
alias gvim='gvim --remote-tab-silent'
alias zshrc='vim ~/.zshrc'
alias tmux='tmux attach || tmux -u'
alias tmuxrc='vim ~/.tmux.conf'
alias python="python -Wall"
alias runserver="DJANGO_DEBUG=1 python manage.py runserver 127.0.0.1:8080"
alias gruntserver="DJANGO_DEBUG=1 python manage.py gruntserver 127.0.0.1:8080"
alias smtpserv="python -m smtpd --debug -n -c DebuggingServer localhost:1025"
alias mkmsgs="python manage.py makemessages"
alias cmplmsgs="python manage.py compilemessages"
alias django_update="cd ~/sources/django-git && git pull && cd docs && make html"
alias dp="dreampie `which python`"
alias sshagent="ssh-agent sh -c 'ssh-add'"
alias lsmod="lsmod | sort | less"
alias syslog="sudo less /var/log/syslog"
alias ghc-sandbox="ghc -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias ghci-sandbox="ghci -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias runhaskell-sandbox="runhaskell -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d"
alias history="history | less"
alias cabal_upgrade="cabal list --simple-output --installed | gawk '{print $1}' | uniq | xargs -I {} cabal install {} --reinstall"


export PS2='%_>'

export PIP_DOWNLOAD_CACHE=$HOME/.cache/pip

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cask/bin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"