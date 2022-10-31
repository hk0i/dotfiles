au! BufWritePost plugins.vim :so %

" Plugs {{{
    call plug#begin()
    " The default plugin directory will be as follows:
    "   - Vim (Linux/macOS): '~/.vim/plugged'
    "   - Vim (Windows): '~/vimfiles/plugged'
    "   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
    " You can specify a custom plugin directory by passing it as the argument
    "   - e.g. `call plug#begin('~/.vim/plugged')`
    "   - Avoid using standard Vim directory names like 'plugin'

    " Make sure you use single quotes

    Plug 'plasticboy/vim-markdown'
    " auto close quotes, parens, brackets
    Plug 'jiangmiao/auto-pairs'
    Plug 'elzr/vim-json'
    Plug 'tpope/vim-fugitive'

    Plug 'mattn/gist-vim' " {
        let g:gist_clip_command = 'pbcopy'
        let g:gist_detect_filetype = 1
        let g:gist_open_browser_after_post = 1
    " }

    Plug 'kballard/vim-swift'
    Plug 'scrooloose/syntastic'
    Plug 'scrooloose/nerdtree'
    Plug 'bling/vim-airline'
    Plug 'airblade/vim-gitgutter'

    Plug 'Valloric/YouCompleteMe' " {
        let g:ycm_key_list_select_completion = [ '<Down', '<C-n>' ]
        let g:ycm_key_list_previous_completion = [ '<Up', '<C-p>' ]
    " }

    " snippets
    Plug 'SirVer/ultisnips' " {
        let g:UltiSnipsExpandTrigger="<Tab>"
        let g:UltiSnipsJumpForwardTrigger="<C-f>"
        let g:UltiSnipsJumpBackwardTrigger="<C-b>"
        " If you want :UltiSnipsEdit to split your window.
        let g:UltiSnipsEditSplit="vertical"
    " }
    " Snippets are separated from the engine. Add this if you want them:
    Plug 'honza/vim-snippets'
    "multiple cursors like sublime
    Plug 'terryma/vim-multiple-cursors'
    "align spaces, tabs, etc..
    Plug 'junegunn/vim-easy-align'
    "trim trailing whitespace
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'voldikss/vim-floaterm'
    " make floaterm background normal
    hi Floaterm guibg=black
    Plug 'alexghergh/nvim-tmux-navigation'

    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    call plug#end()

" }}}
