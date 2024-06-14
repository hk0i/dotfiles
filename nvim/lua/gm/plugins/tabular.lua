return {
    'godlygeek/tabular',
    config = function()
        vim.keymap.set('n', '<leader>t', '<cmd>Tabularize "/ " <cr>')
    end,
}
