-- HTTP/gRPC/WebSocket client для .http и .rest файлов.
-- https://neovim.getkulala.net/docs/getting-started/install/
return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  keys = {
    { "<leader>Rs", desc = "Send request" },
    { "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
    { "<leader>Rr", desc = "Replay last request" },
  },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "",
  },
}
