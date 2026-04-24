return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "day",
    },
    config = function(_, opts)
      local ok, tokyonight = pcall(require, "tokyonight")
      if not ok then
        return
      end
      tokyonight.setup(opts)
      vim.cmd.colorscheme("tokyonight-day")
    end,
  },
}

