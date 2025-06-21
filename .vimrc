" Copyright (c) 2025 Timothy Rost
" SPDX-License-Identifier: MIT

" Turn on syntax highlighting
syntax on

" Show the line number and relative line numbers
set number relativenumber

" New lines inherit indention of the previous line
set autoindent

" React to the syntax and style of code
set smartindent

" The tab key indents by 4 spaces
set tabstop=4

" Auto-indent indents by 4 spaces
set shiftwidth=4

" Convert tab to spaces except in a Makefile
set expandtab
autocmd FileType ^make setlocal expandtab

" Show file stats and cursor position
set ruler

" Encoding
set encoding=utf-8

" Disable the arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" OpenBSD LineNr terminal default is underline -- change to bold
let uname = system("uname")
if uname =~ "OpenBSD" && !has("gui_running")
    highlight LineNr term=bold ctermfg=6 guifg=Brown
endif

" Insert mode mappings for an MIT license
inoremap <expr> //mit License('Timothy Rost', 'MIT', '//')
inoremap <expr> #mit License('Timothy Rost', 'MIT', '#')
inoremap <expr> "mit License('Timothy Rost', 'MIT', '"')

function License(author, license, delimiter)
    let line1 = printf("%s Copyright (c) %d %s\<CR>",
        \ a:delimiter, strftime('%Y'), a:author)
    let line2 = printf("%s SPDX-License-Identifier: %s\<CR>",
        \ a:delimiter, a:license)
    return l:line1 . l:line2
endfunction

