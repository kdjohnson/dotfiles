" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Clang format
Plug 'rhysd/vim-clang-format'

" Vim Airline and Themes
Plug 'vim-airline/vim-airline' | Plug 'vim-airline/vim-airline-themes'

"Git gutter
Plug 'airblade/vim-gitgutter'

" NERDTree
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"Go
Plug 'fatih/vim-go'

"Vim jxs
Plug 'mxw/vim-jsx'

Plug 'rust-lang/rust.vim'

Plug 'sbdchd/neoformat'

Plug 'morhetz/gruvbox'

Plug 'gregsexton/matchtag'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

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
set t_Co=256
au BufReadPost *.jsp set syntax=html

"ClangFormat for java
autocmd FileType java ClangFormatAutoEnable
let g:clang_format#command="clang-format"


" Use deoplete.
let g:deoplete#enable_at_startup = 1

"Jsx syntax for .js files
let g:jsx_ext_required = 0

" Arch Python path
let g:python3_host_prog = '/usr/bin/python'

" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

let g:neoformat_only_msg_on_error = 1

let g:neoformat_javascript_prettier = {
      \ 'exe': 'prettier',
      \ 'args': ['--no-semi', '--single-quote', '--trailing-comma none'],
      \ }

let g:neoformat_enabled_javascript = ['prettier']

let g:neoformat_vue_prettier = {
      \ 'exe': 'prettier',
      \ 'args': ['--no-semi', '--single-quote', '--trailing-comma none'],
      \ }

let g:neoformat_enabled_vue = ['prettier']

" augroup fmt
"     autocmd!
"     autocmd BufWritePre * undojoin | Neoformat
" augroup END

" OSX Python path
" let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.6/bin/python3.6'

" OSX Python path
"let g:ycm_rust_src_path = '/Users/kajuan/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'

" Latex live preview
" let g:livepreview_previewer = 'open -a Preview'

" Linux Python path
" let g:python3_host_prog = '/usr/bin/python3'

" auto open NERDTree
" autocmd vimenter * NERDTree

" close NERDTree if it is the only one open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let g:prettier#config#semi = 'false'
"let g:prettier#autoformat = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql PrettierAsync

inoremap jj <ESC><Right>
noremap <S-H> ^
noremap <S-L> $
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

syntax on
set background=dark
colorscheme gruvbox
