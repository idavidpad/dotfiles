return {
  {
    "ibhagwan/fzf-lua",
    -- 告诉 LazyVim 我们要用 fzf-lua 替代默认的 Telescope 键位
    keys = {
      -- 1. 文件搜索 (类似 Spotlight)
      { "<leader><space>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
      -- 2. 全局搜索 (类似 Grep)
      { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Grep (Global)" },
      -- 3. 搜索当前已打开的文件 (Buffers)
      { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Switch Buffer" },
      -- 4. 搜索最近打开的文件 (Recent)
      { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files" },
      -- 5. 搜索 Git Commits (针对 macOS 开发者)
      { "<leader>gc", "<cmd>FzfLua git_commits<cr>", desc = "Git Commits" },
      -- 6. 搜索命令历史
      { "<leader>sh", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
      -- 7. 搜索当前文件内的函数/符号 (LSP)
      { "<leader>ss", "<cmd>FzfLua lsp_document_symbols<cr>", desc = "Document Symbols" },
    },
    opts = function()
      local config = require("fzf-lua.config")
      local actions = require("fzf-lua.actions")

      return {
        -- 视觉风格：适配 macOS 的现代极简感
        winopts = {
          height = 0.85,
          width = 0.80,
          backdrop = 100, -- 增加背景遮罩浓度
          preview = {
            layout = "vertical", -- 垂直布局更适合宽屏分屏
            vertical = "down:45%",
            scrollbar = "float",
          },
        },
        -- 核心引擎配置
        files = {
          formatter = "path.filename_first", -- 文件名在前，路径在后 (类似 JetBrains)
          fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
        },
        grep = {
          rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
        },
        -- 预览器：强制使用 bat 达到最佳视觉效果
        previewers = {
          bat = {
            cmd = "bat",
            args = "--style=numbers,changes --color always",
            theme = "TokyoNight-Storm", -- 确保与你的主题一致
          },
        },
        -- 快捷键定制：在弹窗内部的操作
        keymap = {
          builtin = {
            ["<c-d>"] = "preview-page-down",
            ["<c-u>"] = "preview-page-up",
          },
          fzf = {
            ["ctrl-q"] = "select-all+accept", -- 一键发送到 Quickfix
          },
        },
      }
    end,
  },
}