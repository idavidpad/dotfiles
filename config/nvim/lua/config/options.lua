-----------idavid add ------------
-- 1. 强制符号列只占 1 列宽度（默认可能是 2）
vim.opt.signcolumn = "yes:1"

-- 2. 限制行号区域的最小宽度（默认是 4）
vim.opt.numberwidth = 2

-- 3. 关闭折叠列（如果不需要显示折叠层级）
-- vim.opt.foldcolumn = "0"

-----------idavid add ------------
vim.cmd("syntax on")
vim.cmd("filetype indent on")
vim.opt.termguicolors = true
vim.opt.smarttab = true
vim.opt.swapfile = false
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.fileencoding = "utf-8"
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = "menuone,noselect"
vim.opt.pumheight = 20
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
-- vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

-- Copy/Paste when using ssh on a remote server
if vim.env.SSH_CONNECTION and pcall(require, "vim.ui.clipboard.osc52") then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
      ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
  }
end

-- Better diagnostic signs
vim.diagnostic.config({
  virtual_text = {
    prefix = "●", -- Could be '●', '▎', 'x', ■
    spacing = 4,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = "",
    },
  },
})
