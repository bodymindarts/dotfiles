set nocompatible

filetype off                " req Vundle

set rtp+=~/.vim/bundle/Vundle.vim    " req Vundle
call vundle#begin()

" vundle handles vundle
Plugin 'gmarik/Vundle.vim'

" plugins:
Plugin 'flazz/vim-colorschemes'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'

call vundle#end()

color jellybeans

autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

filetype plugin indent on        " req Vundle

runtime macros/matchit.vim
syntax on
set autoindent
set colorcolumn=81                      " line width delimiter
set cursorline                          " highlight line at cursor set hlsearch set ignorecase set incsearch
set expandtab                           " use n times <space> instead of <tab>
set hlsearch                            " highlight all search results
set ignorecase                          " ignore case when searching
set incsearch                           " highlight while typing search
set laststatus=2                        " line for status of window
set list                                " show symbols for <eol> and <tab>
set listchars=tab:▸\ ,eol:¬             " set symbols for <eol> and <tab>
set nobackup                            " no backups, no swapfiles
set noswapfile                          " no backups, no swapfiles
set nowritebackup                       " no backups, no swapfiles
set number                              " line number
set shiftwidth=4
set showtabline=2                       " always have tab line
set smartcase                           " search is case sensitive when word starts with uppercase
set softtabstop=4
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=4                           " spaces per tab
set visualbell

augroup vimrc
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,sass,scss,css,javascript,cucumnber
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2
    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumner,vim
        \ autocmd BufWritePre <buffer> :%s/\s\+$//e
    autocmd BufNewFile, BufRead *.json set ft=javascript
    autocmd BufNewFile, BufRead *.md set ft=text
augroup end

let mapleader="-"

nnoremap <cr> :nohlsearch<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap UU <esc>u

" for vim-rspec
nnoremap <Leader>c :call RunCurrentSpecFile()<CR>
nnoremap <Leader>n :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>
