return {
  -- LazyGit
  {
    "kdheepak/lazygit.nvim",
    cmd = "LazyGit",
    keys = { { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" } },
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Conform (форматеры по :Conform или на save)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = "ConformInfo",
    opts = {
      -- Явные настройки форматеров (особенно для локального php-cs-fixer)
      formatters = {
        php_cs_fixer = {
          -- Локальный бинарь из проекта
          command = "vendor/bin/php-cs-fixer",
          args = { "fix", "--using-cache=no", "--quiet", "-" },
          stdin = true,
        },
      },
      formatters_by_ft = {
        lua = { "stylua" },
        php = { "php_cs_fixer", "phpcbf" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        go = { "goimports", "gofmt" },
        python = { "black", "isort" },
      },
    },
  },

  -- Telescope (файлы, grep, буферы)
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    },
    opts = function()
      local telescope = require("telescope")
      pcall(telescope.load_extension, "fzf") -- опционально: если telescope-fzf-native не собрался (нужен make), telescope всё равно работает
      return {}
    end,
  },

  -- Dashboard (стартовый экран; в snacks тоже есть dashboard — при желании отключи один)
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "hyper",
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = " Files", group = "Label", action = function() require("telescope.builtin").find_files() end, key = "f" },
          { desc = " LazyGit", group = "Label", action = "LazyGit", key = "g" },
        },
      },
    },
    config = function(_, opts)
      local ok, dashboard = pcall(require, "dashboard")
      if not ok then return end
      dashboard.setup(opts)
    end,
  },

  -- Auto-session (сохранение/восстановление сессий)
  {
    "rmagatti/auto-session",
    event = "VeryLazy",
    opts = {
      log_level = "info",
      auto_session_suppress_dirs = { "~/", "~/Downloads" },
    },
  },

  -- Git знаки и хунки
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        ignore_whitespace = true,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> • <summary>",
    },
    keys = {
      { "]h", "<cmd>Gitsigns next_hunk<cr>", desc = "Next hunk" },
      { "[h", "<cmd>Gitsigns prev_hunk<cr>", desc = "Prev hunk" },
      { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>", desc = "Stage hunk" },
      { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>", desc = "Reset hunk" },
      { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
    },
  },

  -- Trouble (диагностика, референсы, quickfix)
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    dependencies = "nvim-tree/nvim-web-devicons",
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble diagnostics" },
      { "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix" },
    },
    opts = { use_diagnostic_signs = true },
  },

  -- nvim-lspconfig (явно в списке; серверы поднимаются через mason-lspconfig; setup() нет — только require)
  {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
  },

  -- Bufferline (табы буферов сверху)
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin",
        diagnostics = "nvim_lsp",
      },
    },
  },

  -- Курсор "след"
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Noice (cmdline, popupmenu, notify — выбран вместо wilder: Lua, активная поддержка)
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    opts = {
      cmdline = { view = "cmdline_popup" },
      messages = { view = "mini" },
      notify = { view = "notify" },
    },
  },

  -- Snacks (QoL от folke)
  {
    "folke/snacks.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- LSP progress в статусбаре
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {},
  },

  -- DAP (отладка)
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      local ok, dap = pcall(require, "dap")
      if not ok then return end
      local ok_ui, dapui = pcall(require, "dapui")
      if ok_ui then
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
      end
      local ok_vt, vt = pcall(require, "nvim-dap-virtual-text")
      if ok_vt then vt.setup({}) end
    end,
  },

  -- Комментарии: gc / gcc
  {
    "tpope/vim-commentary",
    event = "VeryLazy",
  },

  -- Toggle terminal
  {
    "akinsho/nvim-toggleterm.lua",
    cmd = "ToggleTerm",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
    },
    opts = {
      -- <C-\> reserved for vim-tmux-navigator (previous pane)
      direction = "float",
      float_opts = { border = "rounded" },
    },
  },

  -- Go helpers
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      pcall(vim.cmd, "GoInstallDeps")
    end,
    opts = {},
  },

  -- Навигация по символам / структура (нет setup(), только require("deepsymbols").get_symbols())
  {
    "ahmedash95/deep-symbols",
    event = "VeryLazy",
  },

  -- TDD workflow
  {
    "zkucekovic/tdd.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Tailwind UX; server.override = false — не регистрируем LSP через lspconfig (убирает deprecation warning в 0.11)
  {
    "luckasRanarison/tailwind-tools.nvim",
    ft = {
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "jsx",
      "php",
      "svelte",
    },
    opts = {
      document_color = { kind = "foreground" },
      server = { override = false },
    },
  },

  -- DB output helper
  {
    "zongben/dbout.nvim",
    cmd = { "DBOutToggle", "DBOutRun" },
    opts = {},
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ok, luasnip = pcall(require, "luasnip")
      if not ok then
        return
      end
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    event = "VeryLazy",
  },

  -- Цвета (#rrggbb и т.п.)
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    opts = {},
  },

  -- Скобки
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    config = function(_, opts)
      local ok, autopairs = pcall(require, "nvim-autopairs")
      if not ok then
        return
      end
      autopairs.setup(opts)
    end,
  },
}

