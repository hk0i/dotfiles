return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons'
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvimtree = require('nvim-tree')

    vim.keymap.set('n', '<Leader>1', '<cmd>NvimTreeToggle<CR>')    -- open/close tree
    vim.keymap.set('n', '<Leader>j', '<cmd>NvimTreeFindFile<CR>')  -- find current file
    nvimtree.setup({})
  end,
}
