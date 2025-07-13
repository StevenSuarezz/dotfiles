return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp", -- Still need this for capabilities
    {
      "folke/lazydev.nvim",
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          -- Load luvit types when the `vim.uv` word is found
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Enhanced capabilities for better LSP experience
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" }
    }

    -- Add folding capability for ufo
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    -- Common on_attach function for keymaps and settings
    local on_attach = function(client, bufnr)
      require("config.plugins.lsp.keymaps").setup(bufnr)
      -- Enable inlay hints if supported
      if client.supports_method("textDocument/inlayHint") then
        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
      end
    end

    -- Configure servers using the new vim.lsp.config() API
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = {
            globals = { 'vim', 'require' },
            disable = { 'missing-fields' }
          },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME }
          },
          telemetry = { enable = false },
          hint = { enable = true }, -- Enable inlay hints
        }
      }
    })

    vim.lsp.config('ts_ls', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = 'all',
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
          }
        }
      }
    })

    vim.lsp.config('pyright', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = 'workspace',
          }
        }
      }
    })

    vim.lsp.config('rust_analyzer', {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ['rust-analyzer'] = {
          cargo = { allFeatures = true },
          checkOnSave = { command = 'clippy' },
          inlayHints = {
            bindingModeHints = { enable = false },
            chainingHints = { enable = true },
            closingBraceHints = { enable = true, minLines = 25 },
            closureReturnTypeHints = { enable = "never" },
            lifetimeElisionHints = { enable = "never", useParameterNames = false },
            maxLength = 25,
            parameterHints = { enable = true },
            reborrowHints = { enable = "never" },
            renderColons = true,
            typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
          },
        }
      }
    })

    -- Setup mason-lspconfig with automatic server enabling
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "rust_analyzer",
        "html",
        "cssls",
        "jsonls",
      },
      automatic_installation = true,
    })

    -- Configure diagnostic display
    vim.diagnostic.config({
      virtual_text = {
        prefix = '●',
        source = "if_many",
      },
      float = {
        source = true,
        border = "rounded",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Customize diagnostic signs
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end
  end
}
