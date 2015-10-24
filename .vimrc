set nocompatible

filetype off                " req Vundle
set rtp+=~/.vim/bundle/vundle " req Vundle
call vundle#begin()
" vundle handles vundle
Plugin 'gmarik/vundle.vim'

" plugins:
Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-bundler'

Plugin 'janko-m/vim-test'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'nginx.vim'

Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'

Plugin 'elixir-lang/vim-elixir'

Plugin 'bodymindarts/vim-twitch'
call vundle#end()

colorscheme jellybeans

let g:jellybeans_overrides = {
\  'Special': { 'guifg': 'de5577' },
\}


autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd BufRead,InsertLeave * match ExtraWhitespace /\s\+$/
highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraLines ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

filetype plugin indent on          " req Vundle

" The following beast is something i didn't write... it will return the
" syntax highlighting group that the current "thing" under the cursor
" belongs to -- very useful for figuring out what to change as far as
" syntax highlighting goes.
nmap <silent> <leader>ps :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

runtime macros/matchit.vim
syntax on
set autoindent
set autoread                       " auto reload when file changes
set autowrite                      " Automatically :write before running commands
set backspace=indent,eol,start     " allow backspace over eol etc.
set colorcolumn=81                 " line width delimiter
set cursorline                     " highlight line at cursor set hlsearch set ignorecase set incsearch
set expandtab                      " use n times <space> instead of <tab>
set foldmethod=manual              " no automatic folding
set hlsearch                       " highlight all search results
set ignorecase                     " ignore case when searching
set incsearch                      " highlight while typing search
set laststatus=2                   " line for status of window
set list                           " show symbols for <eol> and <tab>
set listchars=tab:▸\ ,eol:¬        " set symbols for <eol> and <tab>
set nobackup                       " no backups, no swapfiles
set nofoldenable                   " no automatic folding
set noswapfile                     " no backups, no swapfiles
set nowritebackup                  " no backups, no swapfiles
set number                         " line number
set runtimepath+=~/.vim/xpt-personal
set shiftwidth=2
set showtabline=2                  " always have tab line
set smartcase                      " search is case sensitive when word starts with uppercase
set softtabstop=2
set splitbelow                     " split opens new window below
set splitright                     " vsplit opens new window to the right
set statusline=%f\ %m%r%y%=%3l,%2c
set tabstop=2                      " spaces per tab
set tags+=.git/tags,./.tags
set undodir=~/.vim/undo//
set undofile
set undolevels=1000
set undoreload=10000
set visualbell                     " no beeping
set wildmenu                       " show menu of complete option

augroup vimrc
    autocmd!

    autocmd BufNewFile, BufRead *.json set ft=javascript
    autocmd BufReadPost nginx.conf set ft=nginx
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
    autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>

    autocmd FileType ruby,haml,html,eruby,yaml,sass,scss,css,javascript,cucumber,vim,elixir,cpp
      \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

    autocmd FileType make set softtabstop=8 shiftwidth=8 tabstop=8
    autocmd FileType go set softtabstop=4 shiftwidth=4 tabstop=4

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

let mapleader=" "

nnoremap <cr> :nohlsearch<cr>
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>ez :tabe ~/.zshrc<cr>
nnoremap <leader>x :w<cr>:!chmod +x %<cr>:edit!<cr>
nnoremap <leader>m :!mkdir -p %:p:h<cr>
nnoremap <leader>w :w<cr>
inoremap UU <esc>u
inoremap jj <esc>
nnoremap <leader>sp :tabe ~/.sbt/0.13/plugins/plugins.sbt<cr>

inoremap NN <esc>
inoremap <tab> <BS>

nnoremap s h
nnoremap h l
nnoremap k j
nnoremap l k

onoremap k j
onoremap l k

vnoremap s h
vnoremap h l
vnoremap k j
vnoremap l k

" Quicker window movement
nnoremap <C-n> <C-w>h
nnoremap <C-e> <C-w>l
nnoremap <C-k> <C-w>j
nnoremap <C-l> <C-w>k

" Quicker open alternate
nnoremap <leader><leader> <c-^>

" split window and reset to last
nnoremap vv <c-w>v<c-w>h<c-^>


" use ag for ack
let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <leader>g "zyiw :Ack! <c-r>=@z<CR><CR>

let test#ruby#cucumber#options = '-r features'

nnoremap <silent> <leader>n :TestNearest<CR>
nnoremap <silent> <leader>c :TestFile<CR>
nnoremap <silent> <leader>a :TestSuite<CR>
nnoremap <silent> <leader>l :TestLast<CR>

nnoremap <leader>t :Twitch<CR>
nnoremap <leader>vt :VTwitch<CR>
nnoremap <leader>T :tabnew %<CR>:VTwitch<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Quickfix list management
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! QuickfixFilenames()
    let buffer_numbers = {}
    for quickfix_item in getqflist()
        let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
    endfor
    return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
nnoremap <leader>aq :Qargs<cr>

function! GetBufferList()
    redir =>buflist
    silent! ls
    redir END
    return buflist
endfunction

function! BufferIsOpen(bufname)
    let buflist = GetBufferList()
    for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
        if bufwinnr(bufnum) != -1
            return 1
        endif
    endfor
    return 0
endfunction

function! ToggleQuickfix()
    if BufferIsOpen("Quickfix List")
        cclose
    else
        call OpenQuickfix()
    endif
endfunction

function! OpenQuickfix()
    botright cwindow
    if &ft == "qf"
        cc
    endif
endfunction

nnoremap <leader>q :call ToggleQuickfix()<cr>
nnoremap <leader>rq :cgetfile .git/rspec.quickfix<cr>:call OpenQuickfix()<cr>
nnoremap <leader>sq :cgetfile targe/quickfix/sbt.quickfix<cr>:call OpenQuickfix()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


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
" Selecta Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
    try
        let selection = system(a:choice_command . " | selecta " . a:selecta_args)
    catch /Vim:Interrupt/
        " Swallow the ^C so that the redraw below happens; otherwise there will be
        " leftovers from selecta on the screen
        redraw!
        return
    endtry
    redraw!
    exec a:vim_command . " " . selection
endfunction

function! SelectaFile(path)
  " call SelectaCommand("git ls-files", "", ":e")
  call SelectaCommand("find " . a:path . "/* -type f", "", ":e")
endfunction

nnoremap <leader>f :call SelectaFile(".")<cr>
nnoremap <leader>gv :call SelectaFile("app/views")<cr>
nnoremap <leader>gc :call SelectaFile("app/controllers")<cr>
nnoremap <leader>gm :call SelectaFile("app/models")<cr>
nnoremap <leader>gh :call SelectaFile("app/helpers")<cr>
nnoremap <leader>gl :call SelectaFile("lib")<cr>
nnoremap <leader>gp :call SelectaFile("public")<cr>
nnoremap <leader>gs :call SelectaFile("public/stylesheets")<cr>
nnoremap <leader>gf :call SelectaFile("features")<cr>

"Fuzzy select
function! SelectaIdentifier()
    " Yank the word under the cursor into the z register
    normal "zyiw
    " Fuzzy match files in the current directory, starting with the word under
    " the cursor
    call SelectaCommand("find * -type f", "-s " . @z, ":e")
endfunction
nnoremap <c-g> :call SelectaIdentifier()<cr>

:nohl
