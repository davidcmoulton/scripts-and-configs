" enable filetype detection:
filetype on
filetype plugin on
filetype indent on " filetype-based indentation

" enable syntax highlighting
syntax on

" try to have some sensible indentation even for unknown file types
set autoindent

" display line numbers
set number

" Use an indentation of 2 spaces (instead of tabs) by default
set shiftwidth=2
set tabstop=2
set expandtab

" Override default indentation and use 4-space-width tab stopss for Makefiles
autocmd FileType make set noexpandtab shiftwidth=4 tabstop=4 softtabstop=0

