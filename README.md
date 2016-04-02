# perl-support.vim
  
this plugin:  
 - warning if module name differ from creating file path
 - add PERL5LIB modules to ~/.vim-cpan-module-cache (using perlomni)

## Requirement
[perlomni](https://github.com/c9s/perlomni.vim)  
  
## Installation
In `.vimrc`
```vim
NeoBundle 'duck8823/perl-support.vim'
```
  
## Configuration
```vim
let g:perl_support#module_dirs = [$HOME.'/.perl5lib']
```
