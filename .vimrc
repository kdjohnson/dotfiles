set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo

"Vim Airline
Plugin 'bling/vim-airline'

"Git gutter
Plugin 'airblade/vim-gitgutter'

"Indent Guides
Plugin 'nathanaelkane/vim-indent-guides'

" Vim Colorschemes
Plugin 'flazz/vim-colorschemes'

" Vim match tags
Plugin 'gregsexton/matchtag'

" JSX highlighting
Plugin 'mxw/vim-jsx'


" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
set smartindent
set cursorline
set number
set hlsearch
set statusline+=%F
set ruler
set si
set tabstop=2
set shiftwidth=2
set expandtab
set undofile
set undodir=/Users/kajuan/.vim/.vimundo  
set clipboard=unnamedplus
set mouse=a

" treat jsp files as html
" au BufReadPost *.jsp set syntax=html

" auto open NERDTree
" autocmd vimenter * NERDTree

" close NERDTree if it is the only one open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

inoremap jj <ESC><Right>
noremap <S-H> ^
noremap <S-L> $
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

" Set jsp's to be treated as html
au BufNewFile,BufRead *.jsp set filetype=html

syntax on
colorscheme obsidian
