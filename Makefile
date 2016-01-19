install:
		# rbenv
		git clone https://github.com/rbenv/rbenv.git ~/.rbenv
		# ruby-build
		git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
		# nvm
		wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.1/install.sh | bash
		# oh-my-zsh
		sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
		# composer
		wget -qO- https://getcomposer.org/installer | php
		# vim-plug
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
				https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


