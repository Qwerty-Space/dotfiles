" set the leader key to fullstop
let mapleader=","
set number
syntax on

" spell checking
set spell

" highlighting
set incsearch
set nohlsearch

" tabs -> spaces
set expandtab
set tabstop=4
set shiftwidth=0

" move to previous line by moving left at the start
set whichwrap=b,s,<,>,[,]

command Vb :execute "normal! \<C-v>"

" filetype indenting
filetype plugin indent on

" hide the old mode icon
set noshowmode

" statusline
set laststatus=2
let g:lightline = {
    \ 'colorscheme': 'Tomorrow_Night_Bright',
    \ 'active': {
            \   'left': [ ['mode', 'paste'],
    \             ['readonly', 'filename', 'modified']],
    \   'right': [ ['morelineinfo'],
    \              ['percent'],
    \              ['fileformat', 'fileencoding', 'filetype']],
    \ },
    \ 'component': {
    \   'morelineinfo': '%3l/%L:%-2v'
    \},
\ }

" plugins
call plug#begin('~/.config/nvim/plugged')

" install plugins
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'farmergreg/vim-lastplace'
Plug 'itchyny/lightline.vim'
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }

" initialise plugins
call plug#end()