" plugins
call plug#begin('~/.config/nvim/plugged')

" install plugins
Plug 'tpope/vim-commentary'
Plug 'dhruvasagar/vim-table-mode'
Plug 'preservim/nerdtree'
Plug 'farmergreg/vim-lastplace'
Plug 'godlygeek/tabular'
Plug 'folke/which-key.nvim'

" appearance
Plug 'itchyny/lightline.vim'
Plug 'jan-warchol/selenized', { 'rtp': 'editors/vim' }

" code completion
Plug 'echasnovski/mini.completion'

" initialise plugins
call plug#end()


" colourscheme
colorscheme selenized_bw

" set the leader key to comma
let mapleader=","
set number
syntax on

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

" file type indenting
filetype plugin indent on

" Trim trailing spaces
nnoremap <F5> <cmd>let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" hide the old mode icon
set noshowmode

" status line
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

" mini.completion
lua << EOF
require('mini.completion').setup()
EOF

" mini.completion
inoremap <silent><expr> <Tab> pumvisible() ? '<C-n>' : '<Tab>'
inoremap <silent><expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'

