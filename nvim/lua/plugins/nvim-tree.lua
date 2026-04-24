return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file explorer" },
      { "<leader>ef", "<cmd>NvimTreeFindFile<cr>", desc = "Focus tree on current file" },
    },
    opts = {
      hijack_netrw = true,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      view = {
        width = 32,
        side = "left",
      },
      renderer = {
        root_folder_label = false,
        group_empty = true,
        icons = {
          show = {
            folder = true,
            file = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
    },
    config = function(_, opts)
      local ok, nvim_tree = pcall(require, "nvim-tree")
      if not ok then
        return
      end
      nvim_tree.setup(opts)
    end,
  },
}

