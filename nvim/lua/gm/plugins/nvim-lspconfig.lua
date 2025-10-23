return {
  "neovim/nvim-lspconfig",
  dependencies = {
  event = { "BufReadPre", "BufNewFile" },
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  config = function()
    local lspconfig = vim.lsp.config
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local opts = { noremap = true, silent = true }
    local on_attach = function(_, bufnr)
      opts.buffer = bufnr

      opts.desc = "Show line diagnostics"
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

      opts.desc = "Show documentation for what is under cursor"
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

      -- vnoremap <Leader>c :!swift-chomp-args<CR>
      -- nnoremap <Leader>c V:!swift-chomp-args<CR>

    end

    opts.desc = 'Rename variable'
    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)

    opts.desc = "Go to definition"
    vim.keymap.set("n", "<leader>i", vim.lsp.buf.definition, opts)

    lspconfig("sourcekit", {
      capabilities = capabilities,
      on_attach = on_attach,
    })
    vim.lsp.enable('sourcekit')

    lspconfig('jedi_language_server', {})
    vim.lsp.enable('jedi_language_server')

    -- godot
    lspconfig('gdscript', {
        filetypes = { "gd", "gdscript", "gdscript3" },
    })
    vim.lsp.enable('gdscript')


  end,
}
