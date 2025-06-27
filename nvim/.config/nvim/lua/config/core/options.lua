-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set theme
vim.cmd.colorscheme "elflord"

-- Nerd font for status bar
vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits
vim.o.mouse = "a"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- tabs & indentation
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true

-- Control text wrapping
vim.o.wrap = false
-- vim.o.breakindent = true -- Does nothing with wrap = false

-- search settings
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.cursorline = true

-- terminal colors
vim.o.termguicolors = true
vim.o.background = "dark"
vim.o.signcolumn = "yes"

-- backspace
vim.o.backspace = "indent,eol,start"

-- split windows
vim.o.splitright = true
vim.o.splitbelow = true

-- Save undo history
vim.o.undofile = true

-- Helpful for making things load faster. In milliseconds
vim.o.updatetime = 250

-- Controls how long neovim waits for the next key in a mapped sequence. Default is 1000ms
vim.o.timeoutlen = 300

-- Set how neovim displays whitespace chars in editor
vim.o.list = true
vim.opt.listchars = { 
  tab = "» ",
  trail = "·",
  nbsp = "␣",
  extends = "▶",  -- Character shown when line extends beyond screen
  precedes = "◀", -- Character shown when line starts before screen
}

-- Preview substitutions live as you type
vim.o.inccommand = "split"

-- Show which line the cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor
vim.o.scrolloff = 10

-- Confirm operations that would fail due to unsaved changfes in the buffer (like ':q')
vim.o.confirm = true

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

