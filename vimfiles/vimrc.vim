if has('win32')
 scriptencoding cp932
 set encoding=cp932
 set fileencoding=utf-8
 set fileencodings=iso-2022-jp,utf-8,cp932,euc-jp,default,latin
endif

colorscheme desert

let s:backup_dir=expand('~/vimfiles/tmp')
if !isdirectory(s:backup_dir)
 exec mkdir(s:backup_dir, 'p', 0700)
endif
let &backupdir=s:backup_dir
unlet s:backup_dir

set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab

set number
set list
set listchars=tab:>-,trail:-,extends:>,precedes:<
set cursorline
set laststatus=2
set statusline=%<%F%m\ %r%h%w[%{&fenc}/%{&ff}][%Y]%=(%4l,%4c)%6p%%,%6LL

syntax on
filetype plugin indent on

function! ZenkakuSpace()
 highlight ZenkakuSpace cterm=reverse ctermfg=DarkGray gui=reverse guifg=DarkGray
endfunction

if has('syntax')
 augroup ZenkakuSpace
   autocmd!
   autocmd ColorScheme       * call ZenkakuSpace()
   autocmd VimEnter,WinEnter * match ZenkakuSpace /@/
 augroup END
 call ZenkakuSpace()
endif

au BufRead,BufNewFile *.vimrc  set filetype=vim
au BufRead,BufNewFile *.gvimrc set filetype=vim

