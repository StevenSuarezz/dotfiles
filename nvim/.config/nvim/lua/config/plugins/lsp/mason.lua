return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "prettier",
      },
      auto_update = false,
      run_on_start = true,
    }
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
