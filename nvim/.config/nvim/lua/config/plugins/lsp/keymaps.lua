local M = {}

function M.setup(bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- LSP Navigation
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, vim.tbl_extend('force', opts, { desc = "Go to definition" }))
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, vim.tbl_extend('force', opts, { desc = "Go to declaration" }))
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, vim.tbl_extend('force', opts, { desc = "Go to references" }))
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, vim.tbl_extend('force', opts, { desc = "Go to implementation" }))

  -- Documentation
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, vim.tbl_extend('force', opts, { desc = "Show hover documentation" }))
  vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help,
    vim.tbl_extend('force', opts, { desc = "Show signature help" }))

  -- Code Actions
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, vim.tbl_extend('force', opts, { desc = "Rename symbol" }))
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, vim.tbl_extend('force', opts, { desc = "Code actions" }))
  vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format({ async = true })
  end, vim.tbl_extend('force', opts, { desc = "Format code" }))

  -- Diagnostics
  vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1, float = true })
  end, vim.tbl_extend('force', opts, { desc = "Previous diagnostic" }))
  vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1, float = true })
  end, vim.tbl_extend('force', opts, { desc = "Next diagnostic" }))
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, vim.tbl_extend('force', opts, { desc = "Show diagnostic" }))
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist,
    vim.tbl_extend('force', opts, { desc = "Diagnostic quickfix" }))

  -- Inlay Hints
  vim.keymap.set('n', '<leader>ih', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
  end, vim.tbl_extend('force', opts, { desc = "Toggle inlay hints" }))
end

return M
