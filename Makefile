all: rbenv nvm zsh composer vimplug

composer:
		wget -qO- https://getcomposer.org/installer | php

nvm:
		wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash

rbenv:
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

vimplug:
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

zsh:
		wget -qO- https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | bash
