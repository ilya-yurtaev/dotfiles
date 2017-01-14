all: rbenv nvm composer vimplug stack

composer:
		wget -qO- https://getcomposer.org/installer | php

nix:
		curl https://nixos.org/nix/install | sh

nvm:
		wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash

rbenv:
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv
		mkdir -p ~/.rbenv/plugins/
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

stack:
		wget -qO- https://get.haskellstack.org/ | sh

vimplug:
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

zsh:
		wget -qO- https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
