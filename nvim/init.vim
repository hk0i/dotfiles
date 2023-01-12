let mapleader=" "

"set rtp+=stdpath('config')
runtime plugins.vim

" Stuff from the sample vimrc {{{
    " An example for a vimrc file.
    "
    " Maintainer:	Bram Moolenaar <Bram@vim.org>
    " Last change:	2008 Dec 17
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

    " Use Vim settings, rather than Vi settings (much better!).
    " This must be first, because it changes other options as a side effect.
    set nocompatible

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
" }}}

" colorscheme obsidian2 "requires the 'plugin'

"all `set` settings {{{

    "double slash adds full path to bak file name.
    set backupdir=~/.vim/bak//
    set noswapfile "disable swap files
    set backup

    set number
    highlight LineNr ctermfg=grey ctermbg=darkgrey guibg=#002222

    "default tab settings
    set sw=4
    set softtabstop=4
    "for when tabs are tabs:
    set ts=4
    set expandtab

    "and invisible characters to distinguish tabs and spaces...
    set list
    set listchars=tab:▸·,trail:·,extends:❯,precedes:❮
    set showbreak=↪

    "auto save and load files
    set autoread
    au FocusLost * silent! wa

    "set color column (ruler)
    set cc=80
    hi ColorColumn guibg=#555555

    "incremental search-as-you-type
    set incsearch

    set vb
    set wildmenu "show a menu when doing tab completions

    set wildmode=list:longest
    set wildignore+=.hg,.git,.svn                    " Version control
    set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg   " binary images
    set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
    set wildignore+=*.spl                            " compiled spelling word lists
    set wildignore+=*.sw?,*~                            " Vim swap files
    set wildignore+=*.DS_Store                       " OSX bullshit


    set wildignore+=migrations                       " Django migrations
    set wildignore+=*.pyc                            " Python byte code

    set wildignore+=*.orig                           " Merge resolution files
" }}} /set

" .vim settings {{{
    augroup ft_vim
        au!

        au BufWritePost .vimrc so %
        au BufWritePost .gvimrc so %
        au BufWritePost .vim so ~/.vimrc

        au FileType vim setlocal foldmethod=marker
        au FileType help setlocal textwidth=78
        au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
    augroup END
" }}}

"statusline related {{{
    set laststatus=2
    let g:airline_powerline_fonts = 1
"}}}

" resize vim splits when the window is resized
au VimResized * :wincmd =

"highlight frontmatter (from plasticboy/vim-markdown)
let g:vim_markdown_frontmatter=1

" buffer related {{{
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
" }}} 

" some language specific things {{{
" TODO: move these if they get too big
    " c++ {{{
        autocmd FileType cpp setlocal equalprg=clang-format
    " }}}

    " swift {{{
        augroup ft_swift
            au!
            au FileType swift setlocal foldmethod=marker
            au FileType swift setlocal foldmarker={,}
"            au FileType swift setl makeprg=xcrun\ -sdk\ macosx\ swiftc\ %
            au FileType swift :nnoremap <D-b> :w!<CR>:make<CR>
            "StripWhitespace is from ntpeters/vim-better-whitespace
            au BufWritePre *.swift :StripWhitespace
        augroup END
    " }}}

" }}}

" Only show cursorline in the current window and in normal mode. {{{

augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END
" }}}
" dynamic options {{{
    au InsertEnter * :set norelativenumber|:set number
    au InsertLeave * :set relativenumber
" }}}

" plugin config {{{
    " tpope/vim-markdown {{{
        let g:markdown_fenced_languages = ['java', 'cpp', 'javascript', 'objc']
    " }}}

    "CtrlP {{{
    "add some ignore stuff for CtrlP: DS_Store, jekyll's _site directory,
    "node_modules, ...
        let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|^.git$\|_site'
    "}}}
" }}}

runtime keymap.vim

" https://stackoverflow.com/questions/45247929/system-clipboard-vim-within-tmux-within-ssh-session
function! OscCopy()
  let encodedText=@"
  let encodedText=substitute(encodedText, '\', '\\\\', "g")
  let encodedText=substitute(encodedText, "'", "'\\\\''", "g")
  let executeCmd="echo -n '".encodedText."' | base64 | tr -d '\\n'"
  let encodedText=system(executeCmd)
  if $TMUX != ""
    "tmux
    let executeCmd='echo -en "\x1bPtmux;\x1b\x1b]52;;'.encodedText.'\x1b\x1b\\\\\x1b\\" > /dev/tty'
  else
    let executeCmd='echo -en "\x1b]52;;'.encodedText.'\x1b\\" > /dev/tty'
  endif
  call system(executeCmd)
  redraw!
endfunction
command! OscCopy :call OscCopy()

" make CursorLine appear with a background, like CursorColumn
hi clear CursorLine
hi link CursorLine CursorColumn
