"=============================================================================
" File: perl-support.vim
" Author: maeda
" Created: 2016-04-02
"=============================================================================

scriptencoding utf-8

if !exists('g:loaded_perl_support')
    finish
endif
let g:loaded_perl_support = 1

let s:save_cpo = &cpo
set cpo&vim

let g:perl_support#module_dirs = get(g:, 'perl_support#module_dirs',  [])

command! -nargs=0 FindLocalModules call perl_support#find_local_modules()
autocmd! VimEnter * call perl_support#find_local_modules()
autocmd! BufWritePost *.pm call perl_support#check_package_name()

let &cpo = s:save_cpo
unlet s:save_cpo
