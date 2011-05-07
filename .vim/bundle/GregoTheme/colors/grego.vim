" =============================================================================
" Name: Grego
" Purpose: Another colour scheme using the Tango colour palette
" Maintainer: Gregory McQuillan
" Last Modified: Saturday 04 October 2008 02:06:26 AM IST
" =============================================================================

" Inspired from some Gnome renditions of the Tango colour scheme.

" =============================================================================
" Preamble
" =============================================================================

set background=dark

hi clear

if exists("syntax-on")
syntax reset
endif

let colors_name = "grego"

" =============================================================================
" Vim >= 7.0 specific colours
" =============================================================================

if version >= 700
" No support for cursor line yet
" hi CursorLine term=underline cterm=underline guibg=#111133
" hi CursorColoumn
" hi MatchParen
 hi Pmenu guibg=#5EAFE5
 hi PmenuSel guibg=#888888

endif

" =============================================================================
" General colours
" =============================================================================

hi Normal           guibg=#2E3436 guifg=#eeeeec 
hi Cursor           gui=none guibg=White guifg=Black

hi Folded           guibg=#4D585B guibg=#d2d2d2
" No fold column support yet 
" hi FoldColumn guifg=Orange guibg=DarkBlue
" =============================================================================
" Syntax highlighting
" =============================================================================
"
"com

hi Comment          gui=italic guifg=#6d7e8a ctermfg=Grey
hi Todo             term=bold guifg=#EBC450 
hi Constant         guifg=#8ae234
hi Type             guifg=#8AE234
hi Function         gui=bold guifg=#9BCF8D
hi Statement        guifg=#729FCF
hi Identifier       guifg=#AD7FA8
hi PreProc          guifg=#e9ba6e 
hi Special          term=underline guifg=#5EAFE5
hi Folded             guifg=#FCAD3D  guibg=#Ce5900
"Line numbers
hi LineNr           guifg=#BABDB7 guibg=#000000
hi Search           guibg=#81ABBD
" hi QtClass guifg=Orange ctermfg=LightBlue
"
" My mods
hi Title            guifg=#AD7FA8
hi Directory        guifg=#5EAFE5
