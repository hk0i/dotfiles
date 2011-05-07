set transparency=10
set cursorline
hi cursorline guibg=#444444
set gfn=inconsolata:h13

" for MacVim & Command-T
if has("gui_macvim")
    macmenu &Edit.Find.Find\.\.\. key=<nop>
    map <D-f> :CommandT<CR>
endif
map 'f :CommandT<CR>
