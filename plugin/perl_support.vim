"=============================================================================
" File: perl-support.vim
" Author: maeda
" Created: 2016-04-02
"=============================================================================

scriptencoding utf-8

if exists('g:loaded_perl_support')
	finish
endif
let g:loaded_perl_support = 1

let s:save_cpo = &cpo
set cpo&vim

" find modules in PERL5LIB
function! perl_support#find_local_modules()
	let VITAL = vital#of('perl_support')
	let List = VITAL.import('Data.List')
	let cache = $HOME . "/.vim-cpan-module-cache"
	let modules = []
	if filereadable( cache )
		let modules = readfile(cache)
	endif
	for dir in g:perl_support#module_dirs
		let file_map = substitute(expand(dir . '/**'), '\\', '/', 'g')
		let files = split(file_map, "\n")
		for file in files
			if file !~ '.*\.pm'
				continue
			endif
			let name = substitute(substitute(substitute(file,
						\ dir . '/', '', 'g'),
						\ '/', '::', 'g'),
						\ '\.pm$', '', '')
			call add(modules, name)
		endfor
	endfor
	call writefile(List.uniq(modules), cache)
	echo "PERL5LIB modules were added to ~/.vim-cpan-module-cache"
endfunction

" check package name
function! perl_support#check_package_name()
	let path = substitute(expand('%:p'), '\\', '/', 'g')
	let name = substitute(s:get_package_name(), '::', '/', 'g') . '.pm'
	if path[-len(name):] != name
		echohl WarningMsg
		echomsg "package name is different from file path (".name." : ".path.")"
		echohl None
	endif
endfunction

function! s:get_package_name()
	let mx = '^\s*package\s\+\([^ ;]\+\)'
	for line in getline(1, 5)
		if line =~ mx
			return substitute(matchstr(line, mx), mx, '\1', '')
		endif
	endfor
	return ""
endfunction

function! perl_support#comment_toggle()
	let s:index = line("v")
	let s:end = line(".")
	let s:do_comment = 'false'
	while s:index <= s:end
		if getline(s:index)[col(1)] != '#'
			let s:do_comment = 'true'
		endif
		let s:index = s:index + 1
	endwhile
	let s:index = line("v")
	set paste
	while s:index <= s:end
		call cursor(s:index, 0)
		if s:do_comment == 'true'
			execute ":normal i" . "#"
		else
			execute ":".s:index."s/^#//"
		endif
		let s:index = s:index + 1
	endwhile
	set nopaste
endfunction
let &cpo = s:save_cpo
unlet s:save_cpo
