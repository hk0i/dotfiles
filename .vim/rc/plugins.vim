set nocompatible              " be iMproved, required
filetype off                  " required

au! BufWritePost plugins.vim :so ~/.vimrc

" Plugins {{
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    Plugin 'sampsyo/autolink.vim'

    "auto close quotes, parents, brackets.
"    Plugin 'Raimondi/delimitMate'
    Plugin 'jiangmiao/auto-pairs'

    Plugin 'elzr/vim-json'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    Plugin 'tpope/vim-fugitive'
    Plugin 'mattn/webapi-vim'
    Plugin 'mattn/gist-vim'

    let g:gist_clip_command = 'pbcopy'
    let g:gist_detect_filetype = 1
    let g:gist_open_browser_after_post = 1

    " plugin from http://vim-scripts.org/vim/scripts.html
    Plugin 'L9'
    " Git plugin not hosted on GitHub
    "Plugin 'git://git.wincent.com/command-t.git'

    "Greg's junk
    Plugin 'obsidian2.vim'

    " swift stuff
"    Plugin 'Keithbsmiley/swift.vim'
    Plugin 'kballard/vim-swift'
    Plugin 'scrooloose/syntastic'

    Plugin 'toggle_comment'
    Plugin 'scrooloose/nerdtree'
    Plugin 'bling/vim-airline'
    Plugin 'ctrlp.vim'
    Plugin 'jerrymarino/xcodebuild.vim.git'

    Plugin 'airblade/vim-gitgutter'

    Plugin 'Valloric/YouCompleteMe' " {
        let g:ycm_key_list_select_completion = [ '<Down', '<C-n>' ]
        let g:ycm_key_list_previous_completion = [ '<Up', '<C-p>' ]
    " }

    " snippets
    Plugin 'SirVer/ultisnips' " {
        let g:UltiSnipsExpandTrigger="<Tab>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"
        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"
    " }

    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'

    Plugin 'mileszs/ack.vim'
    "multiple cursors like sublime
    Plugin 'terryma/vim-multiple-cursors'
    "align spaces, tabs, etc..
    Plugin 'junegunn/vim-easy-align'
"    Plugin 'cocoa.vim'

    "trim trailing whitespace
    Plugin 'ntpeters/vim-better-whitespace'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required

    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    "
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line
" }}
