return {
  { 
    -- 'bluz71/vim-nightfly-guicolors',
    -- 'arzg/vim-colors-xcode',
    'rebelot/kanagawa.nvim',
    priority = 1000,
    config = function()
      require('kanagawa').setup({
      })
      -- vim.cmd([[colorscheme nightfly]])
      vim.cmd('colorscheme kanagawa')
    end,
  },
}
