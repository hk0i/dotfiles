" set transparency=5
set cursorline
hi cursorline guibg=#444444
"set gfn=monaco:h15
set gfn=inconsolata\ for\ powerline:h18

" for MacVim & Command-T
if has("gui_macvim")
    macmenu &Edit.Find.Find\.\.\. key=<nop>
    macm Tools.Make key=<nop>

    macm Window.Select\ Next\ Tab key=<nop>
    macm Window.Select\ Previous\ Tab key=<nop>

    nmap <D-}> :bn<CR>
    nmap <D-{> :bp<CR>

    au! BufReadPost plugins.vim map <buffer> <D-b> :w<CR>:so ~/.vimrc<CR>:PluginInstall<CR>
endif
map 'f :CommandT<CR>
