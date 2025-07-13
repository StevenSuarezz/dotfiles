return {
  "kevinhwang91/nvim-ufo",
  dependencies = { "kevinhwang91/promise-async" },
  config = function()
    require('ufo').setup()

    -- Keymaps
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })
    vim.keymap.set('n', '<CR>', 'za', { desc = "Toggle fold" })
  end
}
