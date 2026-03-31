return {
  'nvim-treesitter/nvim-treesitter',
  -- Optional: add build = ":TSUpdate" to ensure parsers update with the plugin
  build = ":TSUpdate",
  config = function()
    -- CHANGE: We now require 'nvim-treesitter' directly instead of '.configs'
    require('nvim-treesitter').setup({
      -- A list of parser names, or "all"
      ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "swift" },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing
      ignore_install = { "javascript" },

      highlight = {
        enable = true,

        -- Using a function to disable for large files
        disable = function(lang, buf)
          -- Also disabling for 'c' and 'rust' as per your original list
          if lang == "c" or lang == "rust" then
              return true
          end

          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,

        additional_vim_regex_highlighting = { 'markdown' },
      },
    })
  end
}
