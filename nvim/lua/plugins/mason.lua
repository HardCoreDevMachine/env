-- Neovim 0.11+: используем vim.lsp.config и vim.lsp.enable вместо require('lspconfig')
return {
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig", -- даёт дефолтные конфиги (cmd, filetypes); в коде ниже не вызываем require('lspconfig')
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function()
      local caps = require("cmp_nvim_lsp").default_capabilities()
      -- Глобальные capabilities для всех LSP
      vim.lsp.config("*", { capabilities = caps })
      -- Клавиши через LspAttach (вместо on_attach)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = vim.keymap.set
          local opts = { buffer = bufnr, silent = true }
          map("n", "gd", vim.lsp.buf.definition, opts)
          map("n", "gy", vim.lsp.buf.type_definition, opts)
          map("n", "gi", vim.lsp.buf.implementation, opts)
          map("n", "gr", vim.lsp.buf.references, opts)
          map("n", "K", vim.lsp.buf.hover, opts)
          map("n", "[d", vim.diagnostic.goto_prev, opts)
          map("n", "]d", vim.diagnostic.goto_next, opts)
          map("n", "<leader>rn", vim.lsp.buf.rename, opts)
          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          map("n", "<leader>f", function()
            vim.lsp.buf.format({ async = true })
          end, opts)
        end,
      })
      -- PHP: intelephense — доп. настройки (размер файла, стабы)
      vim.lsp.config("intelephense", {
        settings = {
          intelephense = {
            files = { maxSize = 5000000 },
            environment = { includePaths = { "" } },
          },
        },
      })

      -- PHP: Psalm — LSP из vendor (composer require vimeo/psalm)
      vim.lsp.config("psalm", {
        cmd = { "vendor/bin/psalm-language-server" },
        root_markers = { "composer.json", "psalm.xml", "psalm.xml.dist" },
        filetypes = { "php" },
        capabilities = caps,
      })
      vim.lsp.enable("psalm")

      return {
        -- Не ставим ensure_installed — установка вручную через :Mason (i на пакете).
        -- Рекомендуемые: lua_ls, intelephense, gopls, pyright, tsserver, svelte, jsonls, html.
        handlers = {
          function(server_name)
            vim.lsp.config(server_name, { capabilities = caps })
            vim.lsp.enable(server_name)
          end,
        },
      }
    end,
  },
}
