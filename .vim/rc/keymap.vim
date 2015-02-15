au! BufWritePost keymap.vim so ~/.vimrc

" bracket completion ((
    "simple bracket completion
"    inoremap {      {}<Left>
"    inoremap {<CR>  {<CR>}<Esc>==O
" )) brackets

"some nice basic keymaps {{{

    "duplicate line cmd-d
    map <D-d> yyp

    " cmd + number for switching tabs
    "map <D-1> 1gt
    "map <D-2> 2gt
    "map <D-3> 3gt
    "map <D-4> 4gt
    "map <D-5> 5gt
    "map <D-6> 6gt
    "map <D-7> 7gt
    "map <D-8> 8gt
    "map <D-9> 9gt
    "map <D-0> 0gt

    " use F keys to switch tabs.
    map <F1> 1gt
    map <F2> 2gt
    map <F3> 3gt
    map <F4> 4gt
    map <F5> 5gt
    map <F6> 6gt
    map <F7> 7gt
    map <F8> 8gt
    map <F9> 9gt
    map <F10> 0gt

    map <S-F1> :vsp ~/.vimrc<CR>
    map <S-F2> :vsp ~/.gvimrc<CR>
    map <S-F3> :vsp ~/.vim/rc/plugins.vim<CR>
    map <S-F4> :vsp ~/.vim/rc/keymap.vim<CR>

    map \ :vnew<CR>
    map _ :new<CR>

    "cmd + number for layout related things
    nmap <D-1> :NERDTreeToggle<CR>

    "toggle_comment to use CMD-/
    map <D-/> q

    " set leader keys to toggle settings
    nnoremap <leader>w :set wrap!<CR>
    nnoremap <leader>n :set number!<CR>
    nmap <leader>h :noh<CR>
    nnoremap ; :
" }}}

" window stuff {{{
    " from http://vim.wikia.com/wiki/Window_zooming_convenience
    "toggles whether or not the current window is automatically zoomed {{{
        function! ToggleMaxWins()
            if exists('g:windowMax')
                au! maxCurrWin
                wincmd =
                unlet g:windowMax
            else
                augroup maxCurrWin
                    au BufEnter * wincmd _ | wincmd |
                    " only max it vertically
                    "au! WinEnter * wincmd _
                augroup END
                do maxCurrWin BufEnter
                let g:windowMax=1
            endif
        endfunction
    " }}}
    noremap <C-w>+ :call ToggleMaxWins()<CR>
"    noremap <C-w>+ <C-w>\|<C-w>_ "cheapo non-toggle version
" }}}

" indent with cmd ] and [ {{{
    vmap <D-[> <gv
    vmap <D-]> >gv
    nmap <D-[> <<
    nmap <D-]> >>
 " }}}

" Navigation mappings {{{


    "jk with linewrap
    nnoremap j gj
    nnoremap k gk

    "swaps g[jk] with [jk]
    nnoremap gj j
    nnoremap gk k

    " center searching
    nnoremap n nzzzv
    nnoremap N Nzzzv

    " simplify moving across splits
    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l

    " Space to toggle folds.
    nnoremap <Space> za
    vnoremap <Space> za
" }}}

" markdown mappings {{{
    "for markdown, fill blanks with cmd ctrl g <C-D-g>
    "these dont' appear to work yet
    au! FileType mkd,markdown,rst nnoremap <C-g> :call autolink#DefCreate()<CR>
    au! FileType mkd,markdown,rst inoremap <C-g> :call autolink#DefCreate()<CR>

" }}} 

