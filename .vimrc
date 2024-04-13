
" Start of dotfile --->
" Use the Solarized Dark theme
set background=dark
colorscheme solarized
let g:solarized_termtrans=1

" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamedplus
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Centralize backups, swapfiles and undo history
set backupdir=~/.vim/backups
set directory=~/.vim/swaps
if exists("&undodir")
	set undodir=~/.vim/undo
endif

" Don’t create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*


" Set LINEs
set nu
set rnu

"HIGHLIGHT
" Enable syntax highlighting
syntax on
" Highlight current line
set cursorline
" Highlight searches
set hlsearch

"TABS
" Make tabs as wide as two spac
set tabstop=2

"CHARACTERS
" Show “invisible” characters
set lcs=tab:▸\ ,trail:·,eol:¬,nbsp:_
set list

"SEARCH
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch

" Always show status line
set laststatus=2
" Enable mouse in all modes
set mouse=a

" Disable error bells
set noerrorbells
" Don’t show the intro message when starting Vim
set shortmess=atI

"CURSOR
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler

"INFO
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3
" Set autocomplete
set omnifunc=syntaxcomplete#Complete

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab



