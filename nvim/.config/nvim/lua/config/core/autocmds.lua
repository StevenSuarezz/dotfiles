-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Add this in your config function after the neo-tree setup
vim.api.nvim_create_autocmd({"BufWritePost", "VimResume", "FocusGained"}, {
  callback = function()
    local events = require("neo-tree.events")
    events.fire_event(events.GIT_EVENT)
  end,
})
