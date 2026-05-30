
-- Общие опции
local opt = vim.opt

-- Включаем мышь во всех режимах
opt.mouse = "a"

-- Нормальные номера строк
opt.number = true
opt.relativenumber = true
opt.wrap = false

-- Копипаста через системный буфер
opt.clipboard = "unnamedplus"

-- Отступы
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- Поиск
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

-- Окна
opt.splitbelow = true
opt.splitright = true

-- Всякий мусор
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- auto-session: сохранять/восстанавливать локальные опции окон
opt.sessionoptions:append("localoptions")

-- Более удобный курсор:
-- - блочный в normal
-- - вертикальная палка в insert
-- - горизонтальная в replace
opt.guicursor = table.concat({
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
}, ",")

-- Подсветка текущей строки и номера строки
-- opt.cursorline = true
-- opt.cursorlineopt = "number,line"

-- Gulp: gulpfile.* = JS/TS, чтобы подхватывал tsserver
vim.filetype.add({
  extension = {
    ["http"] = "http",
    ["rest"] = "rest",
  },
  filename = {
    ["gulpfile.js"] = "javascript",
    ["gulpfile.cjs"] = "javascript",
    ["gulpfile.mjs"] = "javascript",
    ["gulpfile.ts"] = "typescript",
    ["gulpfile.mts"] = "typescript",
  },
})

-- Диагностика в стиле VS Code: float с полным текстом при наведении на строку с ошибкой
vim.diagnostic.config({
  underline = true,
  signs = true,
  virtual_text = {
    prefix = "●",
    format = function(d)
      return " " .. (d.message:gsub("\n", " "):gsub("%s+", " "):sub(1, 60))
    end,
  },
  float = {
    border = "rounded",
    source = "always",
    format = function(d)
      return string.format("%s [%s]\n%s", d.source or "LSP", d.code or d.severity, d.message)
    end,
  },
  severity_sort = true,
})

-- Быстрее показ float при "наведении" (CursorHold срабатывает через updatetime)
vim.opt.updatetime = 300

-- При задержке на строке с ошибкой — показать float с полным сообщением (как hover в VS Code)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diags = vim.diagnostic.get(bufnr, { lnum = lnum })
    if #diags > 0 then
      vim.diagnostic.open_float(bufnr, { scope = "line", focusable = false })
    end
  end,
})

require("config.lazy")
