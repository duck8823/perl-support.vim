# perl-support.vim
  
this plugin:  
 - warning if module name differ from creating file path
 - add local modules to ~/.vim-cpan-module-cache (using perlomni)

## Requirement
[perlomni](https://github.com/c9s/perlomni.vim)  
  
## Installation
In `.vimrc`
```vim
NeoBundle 'duck8823/perl-support.vim'
```
  
## Configuration
In `.vimrc`
```vim
let g:perl_support#module_dirs = ['/path/to/module/dir', '/path/to/module/dir']
```
  
### For Example
```vim
let g:perl_support#module_dirs = [$HOME.'/.perl5lib']
```
