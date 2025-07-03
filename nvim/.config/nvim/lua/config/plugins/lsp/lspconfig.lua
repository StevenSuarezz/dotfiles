return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
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
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
      },
      config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true
            }),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          }),
          sources = cmp.config.sources({
            { name = 'lazydev', group_index = 0 }, -- For Lua development
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
          }, {
            { name = 'buffer' },
            { name = 'path' },
          }),
          formatting = {
            format = function(entry, vim_item)
              -- Add source name to completion items
              vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
                lazydev = "[LazyDev]",
              })[entry.source.name]
              return vim_item
            end,
          },
        })
      end
    },
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Enhanced capabilities for better LSP experience
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = { "documentation", "detail", "additionalTextEdits" }
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
  end
}
