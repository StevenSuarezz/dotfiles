return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "html",
            "cssls",
            "bashls",
            "marksman",
            "ts_ls",
          },
          automatic_installation = true,
        }
      },
      "neovim/nvim-lspconfig",
    },
  }
}
