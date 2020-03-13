" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" use system clipboard
set clipboard=unnamedplus

" filetype stuff
filetype plugin on
syntax on
filetype indent on

" tabs -> spaces
set expandtab
set tabstop=4

" preserve indentation for wrapped lines
autocmd FileType python set breakindentopt=shift:4

" move to previous line by moving left at start, etc
set whichwrap=b,s,<,>,[,]

" show line numbers by default
set nu

" spell checking
"set spell
"setlocal spell spelllang=en_gb

" colours
hi LineNr ctermfg=208
hi Statement ctermfg=214
hi Visual ctermbg=8

" plugins
" update vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins dir
call plug#begin('~/.vim/plugged')

" install plugins
Plug 'preservim/nerdcommenter'
Plug 'farmergreg/vim-lastplace'

" initialise plugins
call plug#end()

