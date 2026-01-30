vim.keymap.set("n", "<ESC>", "<CMD>nohlsearch<CR>")
vim.keymap.set("n", "]d", "<CMD>lua vim.diagnostic.jump({count=1, float=true})<CR>")
vim.keymap.set("n", "[d", "<CMD>lua vim.diagnostic.jump({count=-1, float=true})<CR>")

vim.api.nvim_set_keymap('i', '<Esc>', '<Esc>:<!<cmd>call SetInputMethod("english")<CR>', { noremap = true, silent = true })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Escape to Normal Mode" })
-- 这里的 SetInputMethod 是一个自定义函数，需要你实现

