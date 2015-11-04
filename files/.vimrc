call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer'}
  let g:ycm_autoclose_preview_window_after_completion=1

Plug 'godlygeek/tabular'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'navicore/vissort.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
"Plug 'Shougo/vimshell.vim'
"Plug 'easymotion/vim-easymotion'
"Plug 'jiangmiao/auto-pairs'

" colors
"Plug 'wombat256.vim'

Plug 'kien/ctrlp.vim'
  let g:ctrlp_cmd = 'CtrlPMRU'
  let g:ctrlp_open_new_file = 't'

Plug 'majutsushi/tagbar'
  let g:tagbar_left = 1
  let g:tagbar_autoclose=1
  let g:tagbar_width = 25 
  let g:tagbar_iconchars = ['+', '-']
  let g:tagbar_sort = 0
  noremap <F8> :TagbarToggle<cr>

Plug 'bilalq/lite-dfm'
  ", {'on': 'LiteDFMToggle'}
  nnoremap <Leader>z :LiteDFMToggle<cr>i<Esc>`^

Plug 'scrooloose/nerdtree'
  ", {'on': 'NerdTreeToggle'}
  let g:NERDTreeWinPos="right"
  let NERDTreeCaseSensitiveSort=1
  let NERDTreeChDirMode=2
  let NERDTreeIgnore=["\.pyc$", "\.egg-info$", "\.egg$", "__pycache__"]
  let NERDTreeShowBookmarks=0
  map <F12> :NERDTreeToggle<cr>
  vmap <F12> <esc>:NERDTreeToggle<cr>
  imap <F12> <esc>:NERDTreeToggle<cr>

Plug 'scrooloose/syntastic'
  let g:syntastic_auto_loc_list=1
  let g:syntastic_loc_list_height=5
  let g:syntastic_quiet_messages = { "level": "warnings"}

" snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
  let g:UltiSnipsExpandTrigger="<c-s>"
  let g:UltiSnipsListSnippets="<c-Tab>"
  let g:UltiSnipsJumpForwardTrigger="<c-j>"
  let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Clojure
Plug 'tpope/vim-fireplace'

" Haskell
Plug 'travitch/hasksyn'
"Plug 'lukerandall/haskellmode-vim'
  "au Bufenter *.hs compiler ghc
  "let g:haddock_browser="/usr/bin/firefox"
"Plug 'bitc/vim-hdevtools'
"Plug 'dag/vim2hs'
Plug 'eagletmt/ghcmod-vim'
  let g:ghcmod_use_basedir="/home/ilya/.local/bin"

Plug 'eagletmt/neco-ghc'
"Plug 'lukerandall/haskellmode-vim'

" HTML
Plug 'mattn/emmet-vim'
  let g:user_emmet_expandabbr_key = '<c-e>'
  let g:use_emmet_complete_tag = 1

Plug 'mustache/vim-mustache-handlebars'
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml'

" Lisp
Plug 'kovisoft/slimv'

"CSS
Plug 'groenewege/vim-less'
Plug 'hail2u/vim-css3-syntax'
Plug 'ap/vim-css-color'

" Python
Plug 'jmcantrell/vim-virtualenv'

Plug 'klen/python-mode'
  let g:pymode_doc = 0
  let g:pymode_rope_vim_completion=1
  let g:pymode_rope_extended_complete=1
  let g:pymode_lint_ignore = "E501,E265,E731,F0401,E501,C0110,W0401,W0614,C0301"
  let g:pymode_virtualenv = 1
  let g:pymode_rope_complete_on_dot = 0
  nmap <Leader>j :RopeGotoDefinition<cr>
  map <F7> :PymodeLintAuto <cr>
  imap <F7> <Esc>:PymodeLintAuto<cr>
  vmap <F7> <Esc>:PymodeLintAuto <cr>

" PHP
let g:php_smart_members = 1
let g:php_alt_properties = 1
let g:php_show_semicolon = 1
let g:php_smart_semicolon = 1
let g:php_folding = 0
let g:php_html_in_strings = 1
let g:php_parent_error_close = 1
let g:php_parent_error_open = 1
let g:php_no_shorttags = 1
let g:php_sql_query=1

" Rails
Plug 'tpope/vim-rails'

call plug#end()


set autochdir
set autoindent
set autoread
set background=dark
set backspace=indent,eol,start whichwrap+=<,>,[,]
set backupdir=$HOME/tmp
set directory=$HOME/tmp
set undofile
set undodir=$HOME/tmp
set cmdheight=1
set diffopt=vertical
set encoding=utf-8
set expandtab
set fencs=utf-8,cp1251,koi8-r,cp866
set foldcolumn=0
set foldmethod=manual
set gd
set hidden
set ignorecase smartcase
set incsearch
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
set listchars=tab:>-,trail:-,eol:$,nbsp:%
set lz
set mouse=a
set mousehide
set mousemodel=popup
set nocursorcolumn
set nocursorline
set noerrorbells visualbell t_vb=
set nojoinspaces
set nosmartindent
set nonumber
set paste
set shiftround
set shiftwidth=2
set shm+=AI
set showcmd
set showtabline=2
set smarttab
set softtabstop=2
set spelllang=en_us,ru_ru
set t_Co=256
set tabstop=2
set termencoding=utf-8
set textwidth=0
set virtualedit=block
set wcm=<Tab>
set wildmenu
set wrap

" GUI
"set formatoptions=tcB
set go=eaci " e - gui tabs, c - console dialogs
autocmd GUIEnter * set visualbell t_vb=

set laststatus=2
set statusline=
set statusline+=\ %9*λ\ %6*\ %{bufnr(\"%\")}                                  "current buffer number
set statusline+=%1*\ %F\                                              "file path 
set statusline+=%2*[                                                  "hl
set statusline+=%Y,\                                                  "file type 
set statusline+=%{&encoding},\                                        "encoding 
set statusline+=%{&ff}]%4*                                            "file format
set statusline+=%m%r%h%w\                                             "flags 
set statusline+=%8*                                                   "hl
set statusline+=%{strftime(\"\%d.\%m.\%y\ \%H:\%I\",\ getftime(expand(\"\%\")))}\     "date modified 
set statusline+=%0*%=                                                 "hl and align right
set statusline+=%l:%-3v                                               "line:column
"set statusline+=\ \ \ %7*%L\ %2*lines,\                               "lines count
"set statusline+=%6*%{CharCount()}\ %2*chars,\                         "chars count
"set statusline+=%3*%{getfsize(expand(\"\%\"))}\ %2*bytes\             "bytes count

if has("gui_running")
  set cursorline
  set guitablabel=%t
  let g:clipbrdDefaultReg = '+'
  colors desert

  " ms® windows™ specific
  if has("gui_win32") 
    behave mswin
    se clipboard=unnamed
    language en

    " fullscreen)
    "au GUIEnter * simalt ~xР
    "au GUIEnter * call libcallnr('maximize', 'Maximize', 1)
    se guifont=Consolas:h12:cRUSSIAN

    "preview in browser
    map <Leader>i6 :update<CR>:silent !start "C:\Program Files\Internet Explorer Collection\IE600XPSP2\iexplore.exe" file://"%:p"<cr>
    map <Leader>i7 :update<CR>:silent !start "C:\Program Files\Internet Explorer Collection\IE700\iexplore7.exe" file://"%:p"<cr>
    map <Leader>ie :update<CR>:silent !start c:\progra~1\intern~1\iexplore.exe file://"%:p"<CR>
    map <Leader>ff :update<CR>:silent !start c:\progra~1\Mozill~1\firefox.exe file://"%:p"<CR>
    map <Leader>op :update<CR>:silent !start c:\progra~1\Opera\opera.exe file://"%:p"<CR>
    "google search for word under cursor
    nmap gs "gy:silent !start c:\progra~1\Mozill~1\firefox.exe www.google.com/search?q=<c-r><c-w><cr>

    " gtk specific
  elseif has('gui_gtk2')
    se guifont=Ubuntu\ Mono\ 16
    au GUIEnter * :set lines=99999 columns=99999
    map ,ff :update<CR>:!firefox file://"%:p"<CR><CR>
    map ,ch :update<CR>:!chrome file://"%:p"<CR>
    nmap gs "gy:silent !firefox http://www.google.com/search?q=<c-r><c-w><cr>
  endif


  """ status line colors
endif

set viewoptions=folds,options,cursor
set sessionoptions+=resize,unix,slash
set path+=**
autocmd FileType * exe "setlocal dict+=".escape($VIMRUNTIME.'\syntax\' .&filetype.'.vim',' \$,')
au BufWinEnter *.* silent loadview
au BufWinLeave *.* silent mkview
au BufEnter * exe "set foldcolumn=0"
runtime! ftplugin/man.vim

" omnicomplete
"autocmd FileType python set omnifunc=pysmell#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete


" mappings
let mapleader=","
let g:mapleader=","

imap jj <esc>

nnoremap ; :

map <F2> <esc>:w<cr>
imap <F2> <esc>:w<cr>

map <C-tab> :tabnext<cr>
vmap <C-tab> <esc>:tabnext<cr>
imap <C-tab> <esc>:tabnext<cr>i
map L :tabnext<cr>

map <S-tab> :tabprevious<cr>
vmap <S-tab> <esc>:tabprevious<cr>
imap <S-tab> <esc>:tabprevious<cr>i
map H :tabprevious<cr>

noremap <C-u> <esc>:tabe ~/.vimrc<cr>
imap <C-u> <esc>:tabe ~/.vimrc<cr>

noremap <Leader>r :source ~/.vimrc<cr>

cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>

map <Insert> <Nop>
imap <Insert> <Nop>
vmap <Insert> <Nop>

map <S-insert> "+gPi

imap <C-u> <esc>d^i

nmap <F5> :w !sudo tee > /dev/null %<cr>
vmap <F5> <esc>:w !sudo tee > /dev/null %<cr>
imap <F5> <esc>:w !sudo tee > /dev/null %<cr>

" abbreviations
abbr encutf # coding: utf-8
abbr ipdb import ipdb<cr>ipdb.set_trace()

function! OpenUrl()
" Copyright (c) 2010 Kenko Abe
python << EOM
# coding=utf-8

import vim
import re
import webbrowser

re_obj = re.compile(r'https?://[a-zA-Z0-9-./"#@$%&\':?=_]+')
line = vim.current.line
match_obj = re_obj.search(line)

try:
    url = match_obj.group().strip(".")
    firefox = webbrowser.get("firefox")
    firefox.open_new_tab(url)
    print 'open URL : %s' % url
except:
    print 'failed! : open URL'

EOM
endfunction

command OpenUrl :call OpenUrl()
map <leader>t :OpenUrl<cr>
