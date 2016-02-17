execute pathogen#infect()

set autoindent
set smartindent
set cursorline
set number
set hlsearch
set statusline+=%F
set ruler
set si
set laststatus=2
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set undofile
set undodir=/Users/kajuan/.vim/.vimundo  
set clipboard=unnamedplus
set mouse=a

" auto open NERDTree
" autocmd vimenter * NERDTree

" close NERDTree if it is the only one open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

inoremap jj <ESC><Right>
noremap <S-H> ^
noremap <S-L> $
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

syntax on
filetype plugin indent on
colorscheme hybrid 
