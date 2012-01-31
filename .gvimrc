set transparency=10
set cursorline
hi cursorline guibg=#444444
set gfn=menlo\ bold:h18

" for MacVim & Command-T
if has("gui_macvim")
    macmenu &Edit.Find.Find\.\.\. key=<nop>
    "use cmd-f as cmd-t
    map <D-f> :CommandT<CR>
endif
map 'f :CommandT<CR>
