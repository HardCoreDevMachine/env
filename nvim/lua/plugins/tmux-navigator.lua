-- Seamless navigation between Neovim splits and tmux panes (Ctrl-h/j/k/l).
-- Requires matching bindings in ~/.tmux.conf — see christoomey/vim-tmux-navigator.
return {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
    "TmuxNavigatorProcessList",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Tmux left" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Tmux down" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Tmux up" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Tmux right" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Tmux previous pane" },
  },
}
