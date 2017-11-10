" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

" Clang format
Plug 'rhysd/vim-clang-format'

" Vim Airline and Themes
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

"Git gutter
Plug 'airblade/vim-gitgutter'

" Vim Colorschemes
Plug 'flazz/vim-colorschemes'


" Seattle colorscheme
Plug 'mbbill/vim-seattle'


" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Go
Plug 'fatih/vim-go'

"YouCompleteMe
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

"Janah colorscheme
Plug 'mhinz/vim-janah'

"Vim jxs
Plug 'mxw/vim-jsx'

"Go autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

"Prettier
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql'] }

Plug 'maxst/flatcolor'

Plug 'zacanger/angr.vim'

" Initialize plugin system
call plug#end()


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
"set undodir=/home/kajuan/.vim/.vimundo  
set clipboard=unnamedplus
set mouse=r
set laststatus=2


"ClangFormat for java
autocmd FileType java ClangFormatAutoEnable
let g:clang_format#command="clang-format-4.0"


" JSX Syntax for js files
let g:jsx_ext_required = 0

let g:python3_host_prog = '/usr/bin/python3'

"Jsx syntax for .js files
let g:jsx_ext_required = 0

"Deoplete
let g:deoplete#enable_at_startup = 1

" auto open NERDTree
" autocmd vimenter * NERDTree

" close NERDTree if it is the only one open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:prettier#config#semi = 'false'
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

inoremap jj <ESC><Right>
noremap <S-H> ^
noremap <S-L> $
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h

syntax on
set background=dark
if has('nvim') || has('termguicolors')
  set termguicolors
endif
colorscheme angr
