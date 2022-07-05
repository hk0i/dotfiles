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

    nnoremap <S-F1> :vsp ~/.vimrc<CR>
    nnoremap <S-F2> :vsp ~/.gvimrc<CR>
    nnoremap <S-F3> :vsp ~/.vim/rc/plugins.vim<CR>
    nnoremap <S-F4> :vsp ~/.vim/rc/keymap.vim<CR>

    nnoremap \ :vnew<CR>
    nnoremap _ :new<CR>

    "cmd + number for layout related things
    noremap <D-1> :NERDTreeToggle<CR>
    noremap <D-2> :cw<CR>


    "toggle_comment to use CMD-/
    map <D-/> q

    " set leader keys to toggle settings
    let mapleader=" "
    nnoremap <leader>w :set wrap!<CR>
    nnoremap <leader>n :set number!<CR>
    nmap <leader>h :noh<CR>
    vnoremap <leader>: :Tabularize /:<CR>

    vnoremap Q gq

    :nnoremap <F5> "=strftime("%Y-%m-%d %H:%M:%S %z")<CR>
    :inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M:%S %z")<CR>
    :cnoremap <F5> <C-R>=strftime("%Y-%m-%d-")<CR>
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
" }}}

" markdown mappings {{{
    "for markdown, fill blanks with ctrl g <C-g>
    "these dont' appear to work yet
"    au! FileType mkd,markdown,rst nnoremap <C-g> :call autolink#DefCreate()<CR>
    augroup Markdown
    au!
    au FileType mkd,markdown :nnoremap <C-g> :%!~/bin/mdlinks<CR>
    au Filetype mkd,markdown :set spell
    augroup end

" }}} 
