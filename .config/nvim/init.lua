vim.g.mapleader = " "

local vimrc = vim.fn.stdpath('config')
vim.cmd.source(vimrc .. '/keymap.vim')
vim.cmd.source(vimrc .. '/_init.vim')

require('gm.lazy')
