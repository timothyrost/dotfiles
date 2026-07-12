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

" OpenBSD LineNr terminal default is underline. Change to bold.
let uname = system("uname")
if uname =~ "OpenBSD" && !has("gui_running")
    highlight LineNr term=bold ctermfg=6 guifg=Brown
endif

" Abbreviation ddd inserts the date in ISO8601 format
iabbrev <expr> ddd strftime('%FT%T%z')

" Abbreviation (c) prepends a copyright and MIT license identifier
" using a comment delimiter determined by the file type
augroup CopyrightAbbreviations
	autocmd!
	" Default abbreviation. Exclude .vimrc so creating an abbrevation
	" does not trigger its execution.
	let exclude = ['vim', 'gitcommit']
	autocmd FileType * if index(exclude, &filetype) == -1 |
		\ iabbrev <buffer> (c) <C-O>:call <SID>PrependCopyright('MIT', '$')<CR> |
		\ endif
	" Overrides for specific file types
	autocmd FileType tex,plaintex
		\ iabbrev <buffer> (c) <C-O>:call <SID>PrependCopyright('MIT', '%')<CR>
	autocmd FileType text
		\ iabbrev <buffer> (c) <C-O>:call <SID>PrependCopyright('MIT', '#')<CR>
	autocmd FileType c,cpp
		\ iabbrev <buffer> (c) <C-O>:call <SID>PrependCopyright('MIT', '//')<CR>
augroup END

" Construct a copyright and SPDX license identifier
" license - The SPDX license identifier
" delimiter - A comment delimiter
function! s:Copyright(license, delimiter) abort
	" Get the user's full name using 'getent passwd' and remove
	" the trailing carriage return
    let x = system('getent passwd "$USER" | cut -d ":" -f 5 | cut -d "," -f 1')
	let name = substitute(x, '\r\?\n$', '', '')
    let year = strftime('%Y')
    return printf("%s Copyright (c) %d %s\n%s SPDX-License-Identifier: %s\n\n",
		\ a:delimiter, l:year, l:name, a:delimiter, a:license)
endfunction

" Prepend a header consisting of a copyright and license
" license - The SPDX license identifier
" delimiter - A comment delimiter
function! s:PrependCopyright(license, delimiter) abort
	let header = <SID>Copyright(a:license, a:delimiter)
	call append(0, split(header, "\n"))
endfunction


