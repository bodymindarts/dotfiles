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
Plugin 'tpope/vim-rails'
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

    autocmd BufNewFile, BufRead *.json set ft=javascript
    autocmd BufNewFile, BufRead *.md set ft=text

    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,vim
        \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

    " Jump to last cursor position unless it's invalid or in an event handler
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \ exe "normal g`\"" |
        \ endif
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
inoremap jj <esc>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" for finding tags
nnoremap <C-t> g<C-]>

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>N :call RenameFile()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BREAK UP METHOD CALL (1 arg per line)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! <SID>ArgPerLine()
    if search('(', 'cb', line('.')) == 0
        call search('(', '', line('.'))
    endif
    exec "normal! a\<cr>\<esc>"
    while search(',', '', line('.')) != 0
        exec "normal! a\<cr>\<esc>"
    endwhile
    if search(')', '', line('.')) != 0
        exec "normal! i\<cr>\<esc>"
    endif
endfunction
nnoremap <leader>ba :call <SID>ArgPerLine()<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>
