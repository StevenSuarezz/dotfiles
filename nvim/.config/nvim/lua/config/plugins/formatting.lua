return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Just loads the plugin, doesn't format
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
      },
    })

    vim.keymap.set('n', '<leader>f', function()
      conform.format({ lsp_fallback = true, async = true })
    end, { desc = "Format file" })
  end,
}
