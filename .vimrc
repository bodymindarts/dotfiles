set nocompatible

filetype off                " req Vundle
set rtp+=~/.vim/bundle/Vundle.vim    " req Vundle
call vundle#begin()
" vundle handles vundle
Plugin 'gmarik/Vundle.vim'

" plugins:
" Plugin 'majutsushi/tagbar'      " side bar with local tags
Plugin 'flazz/vim-colorschemes'
Plugin 'kien/ctrlp.vim'
Plugin 'mileszs/ack.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'tpope/vim-commentary'
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
set autoread                            " auto reload when file changes
set backspace=indent,eol,start          " allow backspace over eol etc.
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
set splitbelow                          " split opens new window below
set splitright                          " vsplit opens new window to the right
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=4                           " spaces per tab
set tags+=.git/tags
set visualbell                          " no beeping
set wildmenu                            " show menu of complete option

augroup vimrc
    autocmd!
    autocmd FileType ruby,haml,eruby,yaml,sass,scss,css,javascript,cucumber
        \ setlocal shiftwidth=2 |
        \ setlocal softtabstop=2 |
        \ setlocal tabstop=2
    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,vim
        \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    autocmd BufNewFile, BufRead *.json set ft=javascript
    autocmd BufNewFile, BufRead *.md set ft=text
augroup end

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

let mapleader="-"

nnoremap <cr> :nohlsearch<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
inoremap UU <esc>u
inoremap II <esc>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" for finding tags
nnoremap gT g<C-]>

" for vim-rspec
nnoremap <Leader>c :call RunCurrentSpecFile()<CR>
nnoremap <Leader>n :call RunNearestSpec()<CR>
nnoremap <Leader>l :call RunLastSpec()<CR>
nnoremap <Leader>a :call RunAllSpecs()<CR>


" search hidden files in CtrlP
let g:ctrlp_show_hidden = 1
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" use ag for ack
let g:ackprg = 'ag --nogroup --nocolor --column'
