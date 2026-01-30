return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        skip_confirm_for_simple_edits = true,
        view_options = {
          show_hidden = true,
        },
        -- 新增：配置浮窗参数
        float = {
          padding = 1,
          max_width = 0.9,  -- 限制窗口宽度为 90%
          max_height = 0.9, -- 高度建议保持在 90% 方便查看文件列表
          border = "rounded", -- 圆角边框，更符合 WezTerm 的现代感
          win_options = {
            winhl = "Normal:NormalFloat", -- 确保背景颜色与你的主题一致
          },
        },
      })
  
      -- 修改快捷键：使用 toggle_float 触发 30% 的浮窗
      vim.keymap.set("n", "-", "<CMD>lua require('oil').toggle_float()<CR>", { desc = "Open Oil in 30% float" })
    end,
  },
}