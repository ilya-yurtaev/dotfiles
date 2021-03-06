user_pips:= pip rope jedi importmagic autopep8 yapf flake8

test:
		echo $(HOME)

all: python rbenv nvm composer vimplug stack zsh

composer:
		wget -qO- https://getcomposer.org/installer | php

nix:
		curl https://nixos.org/nix/install | sh

nvm:
		wget -qO- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash

python:
		pip2 install --user --upgrade $(user_pips)
		pip3 install --user --upgrade $(user_pips)

rbenv:
ifeq ($(wildcard ~/.rbenv.),)
		cd ~/.rbenv && git pull
else
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv
endif

ruby-build: rbenv
ifeq ($(wildcard ~/.rbenv/plugins/ruby-build.),)
		cd ~/.rbenv/plugins/ruby-build && git pull
else
		mkdir -p ~/.rbenv/plugins/
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
endif

stack:
		wget -qO- https://get.haskellstack.org/ | sh || stack upgrade

vimplug:
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

zsh:
		wget -qO- https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
