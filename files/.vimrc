let mapleader=","
let g:mapleader=","

noremap <C-u> <esc>:tabe $MYVIMRC<cr>
imap <C-u> <esc>:tabe $MYVIMRC<cr>
noremap <Leader>r :source $MYVIMRC<cr>

set laststatus=0
set incsearch
set hlsearch
set paste
set clipboard=unnamed
set shortmess=I
syntax on
ft on

map <F2> <esc>:w<cr>
