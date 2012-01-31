" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Jul 02
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" vundle config
filetype on "don't crash git
filetype off "required for vundle
set rtp+=~/.vim/vundle.git/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'autonumbering-in-vim'
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'DoxyGen-Syntax'
Bundle 'Markdown'
Bundle 'OmniCppComplete'
Bundle 'The-NERD-tree'
Bundle 'ToggleComment'
Bundle 'Sass'
" Bundle 'snipMate'
Bundle "git://github.com/MarcWeber/vim-addon-mw-utils.git"
Bundle "git://github.com/tomtom/tlib_vim.git"
Bundle 'https://github.com/MarcWeber/snipmate.vim.git'
Bundle 'surround.vim'
Bundle 'https://github.com/reinh/vim-makegreen.git'
Bundle 'https://github.com/plasticboy/vim-markdown.git'

" my theme
Bundle 'GregoTheme'
Bundle 'markdown-snippets'

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
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
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set sw=4
set ts=4
set softtabstop=4
set expandtab
set cindent
" set si
set fdm=syntax

" long line highlighting
autocmd BufRead * highlight OverLength ctermbg=darkgrey guibg=#292929
autocmd BufRead * match OverLength /\%80v.*/
set textwidth=80
set number
colorscheme grego

" map meta keys for gui mode
" map <A-1> 1gt
" map <A-2> 2gt
" map <A-3> 3gt
" map <A-4> 4gt
" map <A-5> 5gt
" map <A-6> 6gt
" map <A-7> 7gt
" map <A-8> 8gt
" map <A-9> 9gt

map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> 10gt


map <C-t> :tabnew<CR>
"map <C-W> :tabclose<CR>

"autocompletes
filetype on
filetype plugin on
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#CompleteCpp

set backupdir=~/.vim/bak

" set up whitespace drawing stuff.
set listchars=tab:▸-,trail:·,extends:>,precedes:<
set list
" toggle listchars key
map ,l :set list!<CR>:set expandtab!<CR>
"toggle line wrapping
map ,m :set wrap!<CR>
" refresh syntax highlighting
noremap <silent> ,k :syntax sync minlines=200<CR>

" toggle command for NERDTree
noremap <silent> ,, :execute 'NERDTreeToggle ' . getcwd()<CR>
noremap <silent> ,. :NERDTreeMirror<CR>

" i was using these before!!
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabContextDefaultCompletionType = "<c-n>"

" let g:SuperTabMappingForward='<s-tab>'
" let g:SuperTabMappingBackward='<tab>'

"set guifont="DejaVu Sans Mono":h8:cDEFAULT
" set guifont=DejaVu\ Sans\ Mono\ 9

" Mappings for plugin/ToggleComment.vim

noremap <silent> ,# :call CommentLineToEnd('# ')<CR>^
noremap <silent> ;# :call CommentLineToEnd('### ')<CR>^
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>^
noremap <silent> ," :call CommentLineToEnd('" ')<CR>^
noremap <silent> ,; :call CommentLineToEnd('; ')<CR>^
noremap <silent> ,- :call CommentLineToEnd('-- ')<CR>^
noremap <silent> ,* :call CommentLinePincer('/* ', ' */')<CR>^
noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>^

" and/or Filetype specific mappings: Meta-c (Alt-c) and Meta-Shift-C

autocmd FileType c    noremap <silent> <buffer> <M-c> :call CommentLineToEnd ('// ')<CR>^
autocmd FileType c    noremap <silent> <buffer> <M-C> :call CommentLinePincer('/* ', ' */')<CR>^
autocmd FileType make noremap <silent> <buffer> <M-c> :call CommentLineToEnd ('# ')<CR>^
autocmd FileType html noremap <silent> <buffer> <M-c> :call CommentLinePincer('<!-- ', ' -->')<CR>^

"php folding
map <F5> <Esc>:EnableFastPHPFolds<Cr>
map <F6> <Esc>:EnablePHPFolds<Cr>
map <F7> <Esc>:DisablePHPFolds<Cr>

" doxygen file syntax highlighting
au BufNewFile,BufRead *.doxygen setfiletype doxygen
au! BufRead,BufNewFile *.sass setfiletype sass
au BufRead,BufNewFile *.scss set filetype=scss

" ctrl-c, ctrl-v copy & paste
map <C-c> "+y
"map <C-v> "+p

set cursorline
hi CursorLine guibg=#222222

"set status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]\ [%{&ff}]

au BufWritePre *.java,*.cpp,*.php,*.phtml :%s/\(\s\+$\|\s\r\+$\)//ge
au BufWritePost hosts :w! %:p.ac

" map <Tab> >>
" map <S-Tab> <<

" disable annoying bell in graphical vim
set vb t_vb=

map ;f :CommandT<CR>
map <D-F> :CommandTFlush<CR>
map <F10> :e /Applications/MAMP/conf/apache/extra/httpd-vhosts.conf<CR>

autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
au BufWritePost .gvimrc,.vimrc :so %

let g:jekyll_path = "/Users/gmcquillan/Dropbox/otaku-elite/jekyll/"
execute "autocmd BufNewFile,BufRead " . g:jekyll_path . "/* syn match jekyllYamlFrontmatter /\\%^---\\_.\\{-}---$/ contains=@Spell"
