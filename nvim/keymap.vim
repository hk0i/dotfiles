au! BufWritePost keymap.vim so %

" keymap {{{
" use F keys to switch tabs {{{
    nnoremap <F1> 1gt
    nnoremap <F2> 2gt
    nnoremap <F3> 3gt
    nnoremap <F4> 4gt
    nnoremap <F5> 5gt
    nnoremap <F6> 6gt
    nnoremap <F7> 7gt
    nnoremap <F8> 8gt
    nnoremap <F9> 9gt
    nnoremap <F10> 0gt
" }}}

    nnoremap <S-F1> :exe 'vsp' stdpath('config') . '/init.vim'<CR>
    nnoremap <S-F3> :exe 'vsp' stdpath('config') . '/plugins.vim'<CR>
    nnoremap <S-F4> :exe 'vsp' stdpath('config') . '/keymap.vim'<CR>

    " Use F13-16 when Shift-F1-F4 don't work
    nnoremap <F13> :exe 'vsp' stdpath('config') . '/init.vim'<CR>
    nnoremap <F15> :exe 'vsp' stdpath('config') . '/plugins.vim'<CR>
    nnoremap <F16> :exe 'vsp' stdpath('config') . '/keymap.vim'<CR>

    " leader commands {{{
    " file commands {{{
    nnoremap <Leader>bd :bd<CR>
    nnoremap <Leader>q :q<CR>
    nnoremap <Leader>Q :qall<CR>
    nnoremap <Leader>w :w<CR>
    nnoremap <Leader>e :e<CR>
    nnoremap <Leader>1 :NERDTreeToggle<CR>
    nnoremap <Leader>j :NERDTreeFind<CR>
    " }}}

    vnoremap <Leader>i :!swiftformat --quiet --fragment true<CR>
    vnoremap <Leader>p :!swift-autoinit<CR>
    vnoremap <Leader>s :!sort<CR>
    nnoremap <Leader>s vip:!sort<CR>

    vnoremap <Leader>c :!swift-chomp-args<CR>
    nnoremap <Leader>c V:!swift-chomp-args<CR>

    " zip to end of line functions
    nnoremap <Leader>z x$p
    " zip to character before last, useful for avoiding semicolons
    nnoremap <Leader>Z x$P

    nnoremap <Leader>n :set number!<CR>:set relativenumber!<CR>

    " fzf / file open
    nnoremap <Leader>F :Files<CR>
    nnoremap <Leader>f :GFiles<CR>
    nnoremap <Leader>h :History<CR>
    nnoremap <Leader>b :Buffers <CR>
    nnoremap <delete> :Buffers<CR>
    nnoremap <Leader>r :Rg <C-R><C-W><CR>
    nnoremap <Leader>R :Rg 
    nnoremap <Leader>m :BLine MARK: <CR>

    nnoremap <Leader><Space> za
    nnoremap <Leader>g :FloatermNew lazygit<CR>
    " }}}

    " easy window switching {{{
    " nnoremap <C-h> <C-w><C-h>
    " nnoremap <C-j> <C-w><C-j>
    " nnoremap <C-k> <C-w><C-k>
    " nnoremap <C-l> <C-w><C-l>
    " The tmux-navigator way (nvim-tmux-navigation)
    nnoremap <silent> <C-h> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>
    nnoremap <silent> <C-j> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>
    nnoremap <silent> <C-k> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>
    nnoremap <silent> <C-l> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>
    nnoremap <silent> <C-\> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>
    nnoremap <silent> <C-Space> :lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>
    " }}}

    noremap Q gq
    vnoremap Q gq
    " select last put (pasted) line
    nnoremap gp `[v`]

    " date inserters {{{
    :nnoremap <F5> "=strftime("%Y-%m-%d %H:%M:%S %z")<CR>
    :inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S %z")<CR>
    :cnoremap <F5> <C-R>=strftime("%Y-%m-%d-")<CR>
    " }}}

    " Navigation mappings {{{
        " Possibly causes a performance hit?
        "jk with linewrap
       " nnoremap j gj
       " nnoremap k gk

       " "swaps g[jk] with [jk]
       " nnoremap gj j
       " nnoremap gk k
    " }}}

    " Move lines down/up with alt + j/k
    nnoremap <M-j> ddp
    nnoremap <M-k> ddkP
    nnoremap <M-]> :bn<CR>
    nnoremap <M-[> :bp<CR>

    " markdown mappings {{{
        "for markdown, fill blanks with ctrl g <C-g>
        "these dont' appear to work yet
        augroup Markdown
        au!
        au FileType mkd,markdown :nnoremap <C-g> :%!~/bin/mdlinks<CR>
        au Filetype mkd,markdown :set spell
        augroup end
    " }}}

    " center searching
    nnoremap n nzzzv
    nnoremap N Nzzzv

" }}}
