return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    -- Required setup
    harpoon:setup()
    
    -- Basic Keymaps
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
    vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })
    vim.keymap.set("n", "<leader>hx", function() harpoon:list():remove() end, { desc = "Harpoon remove file" })
    vim.keymap.set("n", "<leader>hX", function() harpoon:list():clear() end, { desc = "Harpoon clear all" })
    
    -- Quick file access
    vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
    vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
    vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
    vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
    
    -- Navigate through harpoon list
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev file" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next file" })

    -- Ufo extension
    harpoon:extend(require("harpoon.extensions").builtins.command_on_nav('UfoEnableFold'))
    --require("harpoon"):extend(require("harpoon.extensions").builtins.command_on_nav('UfoEnableFold'))
  end,
}
