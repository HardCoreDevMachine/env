local M = {}

local root_markers = {
  "mvnw",
  "pom.xml",
  "gradlew",
  "build.gradle",
  "build.gradle.kts",
  "settings.gradle",
  "settings.gradle.kts",
  ".git",
}

local function workspace(root)
  return vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.sha256(root):sub(1, 16)
end

local function glob(pattern)
  return vim.fn.glob(pattern, false, true)
end

local function bundles()
  local packages = vim.fn.stdpath("data") .. "/mason/packages"
  local result = {}
  local debug = glob(packages .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
  local tests = glob(packages .. "/java-test/extension/server/*.jar")

  for _, jar in ipairs(debug) do
    table.insert(result, jar)
  end
  for _, jar in ipairs(tests) do
    table.insert(result, jar)
  end
  return result, #tests > 0
end

local function jdtls_command()
  local command = vim.fn.exepath("jdtls")
  if command ~= "" then return command end

  local mason_command = vim.fn.stdpath("data") .. "/mason/bin/jdtls"
  if vim.fn.executable(mason_command) == 1 then return mason_command end
end

local function java_home()
  local candidates = { vim.env.JAVA_HOME }
  vim.list_extend(candidates, glob("/usr/lib/jvm/*"))
  local best, best_major = nil, -1
  for _, dir in ipairs(candidates) do
    local java = dir and (dir .. "/bin/java")
    if java and vim.fn.executable(java) == 1 then
      local version = vim.fn.system({ java, "-version" })
      local major = tonumber(version:match('version "1%.8')) and 8
        or tonumber(version:match('version "(%d+)'))
        or 0
      if major > best_major then best, best_major = dir, major end
    end
  end
  if best_major >= 21 then return best end
end

local function start(bufnr)
  if vim.bo[bufnr].filetype ~= "java" or vim.b[bufnr].jdtls_started then return end

  local root = vim.fs.root(bufnr, root_markers)
  if not root then
    vim.notify("Java project root not found (pom.xml, Gradle files, or .git)", vim.log.levels.WARN)
    return
  end

  local command = jdtls_command()
  if not command then
    vim.notify("JDTLS is not installed: run :MasonInstall jdtls", vim.log.levels.ERROR)
    return
  end
  local bundle_list, has_tests = bundles()

  local config = {
    name = "jdtls",
    cmd = { command, "-data", workspace(root) },
    cmd_env = { JAVA_HOME = java_home() },
    root_dir = root,
    settings = {
      java = {
        eclipse = { downloadSources = true },
        maven = { downloadSources = true },
        implementationsCodeLens = { enabled = true },
        referencesCodeLens = { enabled = true },
        signatureHelp = { enabled = true },
      },
    },
    init_options = { bundles = bundle_list },
  }

  require("jdtls").start_or_attach(config)
  vim.b[bufnr].jdtls_started = true

  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
  end

  map("n", "<leader>jo", function() require("jdtls").organize_imports() end, "Java organize imports")
  map("n", "<leader>jc", "<cmd>JdtCompile<cr>", "Java compile")
  map("n", "<leader>jr", "<cmd>JdtRestart<cr>", "Java restart JDTLS")
  map("n", "<leader>jm", "<cmd>JdtJshell<cr>", "Java JShell")
  if has_tests then
    map("n", "<leader>jf", function() require("jdtls").test_class() end, "Java test class")
    map("n", "<leader>jn", function() require("jdtls").test_nearest_method() end, "Java test method")
  end
end

function M.setup()
  local group = vim.api.nvim_create_augroup("UserJdtls", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "java",
    callback = function(event) start(event.buf) end,
  })

  if vim.bo.filetype == "java" then start(0) end
end

return M
