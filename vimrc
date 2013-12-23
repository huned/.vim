" An example for a vimrc file.
"
" Maintainer:  Bram Moolenaar <Bram@vim.org>
" Last change:  2002 Sep 19
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"        for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"      for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set mouse=a

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set nobackup    " do not keep a backup file, use versions instead
set history=50    " keep 50 lines of command line history
set ruler    " show the cursor position all the time
set showcmd    " display incomplete commands
set ignorecase
set smartcase
set nohlsearch
set dir=~/.vim/tmp

set autoindent
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Don't use Ex mode, use Q for formatting
map Q gq

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

if has("gui_running")
  " colorscheme ir_black
  colorscheme molokai
  set lines=42 columns=80
  "set guifont=Inconsolata:h14
  set guifont=Monaco:h12
  set guioptions-=T
  set transparency=1
endif

" Setup for multibyte
if has("multi_byte")
  set fileencodings=ucs-bom,utf-8
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent    " always set autoindenting on

endif " has("autocmd")

" Optional, handy TagList settings

:nnoremap <silent> <F8> :Tlist<CR>

let Tlist_Compact_Format = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Exit_OnlyWindow = 1

" expand fg lookups
set path+=./app/**
set suffixesadd=.rb
"" set includeexpr+=substitute(v:fname,'s$','','g')
"" or you can add substitution pattern s/ies$/y/g, s/ves$/f/g like this:
set includeexpr+=substitute(substitute(substitute(v:fname,'s$','','g'),'ie$','y','g'),'ve$','f','g')
map <F11> <Esc>:set suffixesadd=.rb<cr>gf
map <F12> <Esc>:set suffixesadd=.rhtml<cr>gf

set background=dark
set viminfo=%,'50,\"100,n~/.viminfo

au BufRead,BufNewFile *.scss set filetype=scss
au BufRead,BufNewFile *.coffee set filetype=coffee

"code folding
"set foldmethod=indent
"et foldnestmax=10
"et foldlevel=1

"display dots for whitespace
set list listchars=trail:·

" exclude using wildignore
set wildignore+=*/tmp/*,*/.tmp/*,*.so,*.swp,*.zip,.DS_Store

" additional excludes for delicious-web
set wildignore+=*/wrap/*,*/node_modules/*,*/.git/*,*/.bundle/*,*/.vagrant/*,*/doc/*,*/vendor/*
set wildignore+=*.png,*.gif,*.jpe?g,*.ico

"indent
"autocmd VimEnter * :IndentGuidesEnable
"let g:indent_guides_guide_size=1

call pathogen#infect()
