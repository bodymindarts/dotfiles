set nocompatible 			" req Vundle
filetype off				" req Vundle

set rtp+=~/.vim/bundle/Vundle.vim	" req Vundle

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'faith/vim-go'
Plugin 'altercation/vim-colors-solarized.git'
call vundle#end()

filetype plugin indent on		" req Vundle

syntax on
" set background=dark			" req solarized
" let g:solarized_termcolors=256		" req solarized
" colorscheme solarized			" req solarized	

set autoindent
