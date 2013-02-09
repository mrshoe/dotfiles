set nowrap
syntax on
set tabstop=4
set autoindent
set smartindent
set nosol
set backspace=indent,eol,start
set sta
set nocp
set shiftwidth=4
set wildignore=*.bak,*.pyc
let g:alternateExtensions_m = "h"
let g:alternateExtensions_h = "c,cpp,m"
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
map + <C-W>+
map - <C-W>-
map <C-M> :FufTaggedFile<CR>
autocmd BufNewFile,BufRead,WinEnter *.py call PreparePython()
autocmd BufNewFile,BufRead,WinEnter *.hs call UseSpaces()
autocmd BufNewFile,BufRead,WinEnter *.h,*.m,*.cpp,*.c call DetectSpaces()
set novb
set vb
filetype on
"source /Users/mrshoe/installers/a.vim
set runtimepath +=/Users/mrshoe/installers/fuzzyfinder
set runtimepath +=/Users/mrshoe/installers/l9
set number

set background=dark
set encoding=utf-8
set listchars=tab:▸\ ,eol:¬
set list
highlight LineNr ctermfg=0 cterm=bold
highlight NonText ctermfg=0 cterm=bold
highlight SpecialKey ctermfg=0 cterm=bold
highlight Visual ctermbg=245
highlight PreProc ctermfg=2 cterm=bold
highlight Type ctermfg=6
function! UseSpaces()
	set expandtab
	set softtabstop=4
endfunction
function! UseTabs()
	set noexpandtab
	set softtabstop=0
endfunction
function! PreparePython()
	set cinwords=if,elif,else,for,while,try,except,def,class
	call DetectSpaces()
endfunction
function! DetectSpaces()
	let l:lineno = 1
	let l:numlines = line("$")
	let l:numtablines = 0
	let l:numspacelines = 0
	while l:lineno <= l:numlines
		let l:line = getline(l:lineno)
		let l:lineno = l:lineno + 1
		if -1 != match(l:line, '^ \+[a-zA-Z_]\+')
			let l:numspacelines = l:numspacelines + 1
		elseif -1 != match(l:line, '^\t\+[a-zA-Z_]\+')
			let l:numtablines = l:numtablines + 1
		endif
	endwhile
	if l:numspacelines > l:numtablines
		call UseSpaces()
	else
		call UseTabs()
	endif
endfunction

function! DoP4Diff()
	!p4diff > ~/.p4diff.out
	sp ~/.p4diff.out
endfunction

function! DoBreakpoint(filename)
	execute "!osascript /Users/mrshoe/bin/breakpoint.scpt " . a:filename . " " . line(".")
endfunction

function! UpdateFufTags()
	FufTaggedFile
	q
	q
endfunction

function! SetTags()
	if -1 != match(getcwd(), 'Firmware')
		let branch="/Users/mrshoe/ipod/" . readfile("/Users/mrshoe/ipod/current")[0]
		let &tags=branch . "/Firmware/tags," . branch . "/Firmware/SilverML.tags"
	else
		let &tags=getcwd() . "/tags"
	endif
endfunction

"call SetTags()

nmap <silent> ;d :call DoP4Diff()<CR><CR>
nmap <silent> ;b :call DoBreakpoint("%:p")<CR><CR>
nmap <silent> ;p :!p4 edit %<CR>
nmap <silent> ;r :!p4 revert %<CR>
nmap <silent> ;w :s/\t/    /g<CR>
nmap <silent> ;W :s/    /\t/g<CR>
nmap <silent> ;l :ts <C-R><C-W><CR>
vmap <silent> ;w :s/\t/    /g<CR>
vmap <silent> ;W :s/    /\t/g<CR>
" remap # in insert mode so that vim doesn't remove all indentation on lines that start with #
inoremap # X#
