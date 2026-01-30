local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- ==========================================================
-- 1. 性能 & 字体
-- ==========================================================
config.front_end = "WebGpu"

config.font = wezterm.font_with_fallback({
    { family = "JetBrains Mono", weight = "Medium" },
    "Symbols Nerd Font Mono",
})

config.font_size = 14.0
config.adjust_window_size_when_changing_font_size = false

-- ==========================================================
-- 2. 外观：极简、无标题栏（不赌 macOS）
-- ==========================================================
config.color_scheme = "Tokyo Night"

config.window_background_opacity = 0.85
config.macos_window_background_blur = 30

-- 🔥 核心：彻底移除 macOS TITLE
-- config.window_decorations = "RESIZE"

-- ==========================================================
-- 3. Tab Bar：只作为占位（不用、不消失）
-- ==========================================================
config.tab_bar_at_bottom = true -- 顶部标签栏
-- config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true --不显示标题栏
--
-- wezterm.on("format-tab-title", function()
--     return { { Text = " " } }
-- end)
--
-- config.colors = {
--     tab_bar = {
--         background = "rgba(0,0,0,0)",
--         active_tab = {
--             bg_color = "#7aa2f7",
--             fg_color = "#7aa2f7",
--         },
--         inactive_tab = {
--             bg_color = "rgba(0,0,0,0)",
--             fg_color = "rgba(0,0,0,0)",
--         },
--     },
-- }
--
-- ==========================================================
-- 4. 键盘哲学：Cmd = 系统，其余 = tmux
-- ==========================================================
config.disable_default_key_bindings = true

config.keys = {
    -- 系统级
    { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
    { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
    { key = "q", mods = "CMD", action = act.QuitApplication },
    { key = "h", mods = "CMD", action = act.HideApplication },
    { key = "m", mods = "CMD", action = act.Hide },

    -- 字体
    { key = "+", mods = "CMD", action = act.IncreaseFontSize },
    { key = "-", mods = "CMD", action = act.DecreaseFontSize },
    { key = "0", mods = "CMD", action = act.ResetFontSize },

    -- WezTerm 窗口
    { key = "n", mods = "CMD", action = act.SpawnWindow },
    { key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },

    -- 🔥 真正的全屏（稳定、唯一）
    -- Ctrl + Cmd + Enter
    { key = "Enter", mods = "CTRL|CMD", action = act.ToggleFullScreen },
}

-- ==========================================================
-- 5. 鼠标：只保留右键粘贴（可删）
-- ==========================================================
config.mouse_bindings = {
    {
        event = { Up = { streak = 1, button = "Right" } },
        mods = "NONE",
        action = act.PasteFrom("Clipboard"),
    },
}

-- ==========================================================
-- 6. 启动 tmux
-- ==========================================================
config.set_environment_variables = {
    TERM = "xterm-256color",
}

config.default_prog = {
    "/usr/local/bin/tmux",
    "-u",
}

-- ==========================================================
-- 7. 体验优化
-- ==========================================================
config.scrollback_lines = 10000
config.enable_scroll_bar = false
config.audible_bell = "Disabled"

return config

-- local wezterm = require("wezterm")
-- local act = wezterm.action
--
-- local config = wezterm.config_builder()
--
-- -- =========================
-- -- 1. 基础性能与字体
-- -- =========================
-- config.front_end = "WebGpu"
-- config.font = wezterm.font_with_fallback({
--     { family = "JetBrains Mono", weight = "Medium" },
--     "Symbols Nerd Font Mono",
-- })
-- config.font_size = 14.0
--
-- -- =========================
-- -- 2. 外观：为 tmux 提供纯净背景
-- -- =========================
-- config.color_scheme = "Tokyo Night"
-- config.window_background_opacity = 0.85
-- config.macos_window_background_blur = 30
-- config.window_decorations = "RESIZE" -- 隐藏标题栏，保持极简
-- -- config.hide_tab_bar_if_only_one_tab = true -- 既然用 tmux，WezTerm 的 Tab 就没用了
--
-- -- =========================
-- -- 3. 核心：彻底透传快捷键给 tmux
-- -- =========================
-- -- 禁用所有默认快捷键，防止 WezTerm 拦截键盘指令
-- config.disable_default_key_bindings = true
--
-- config.keys = {
--     -- A. 仅保留 macOS 必须的系统级操作
--     { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
--     { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
--     { key = "q", mods = "CMD", action = act.QuitApplication },
--     { key = "h", mods = "CMD", action = act.HideApplication },
--     { key = "m", mods = "CMD", action = act.Hide },
--     { key = "f", mods = "CMD", action = act.ToggleFullScreen },
--     { key = "+", mods = "CMD", action = act.IncreaseFontSize },
--     { key = "-", mods = "CMD", action = act.DecreaseFontSize },
--     { key = "0", mods = "CMD", action = act.ResetFontSize },
--
--     -- B. WezTerm 窗口操作（不使用 Leader 键，直接用 Cmd）
--     -- 这样你的 Ctrl-f 永远属于 tmux
--     { key = "n", mods = "CMD", action = act.SpawnWindow },
--     { key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
-- }
--
-- -- =========================
-- -- 4. 环境与路径
-- -- =========================
-- config.set_environment_variables = {
--     -- 告诉 tmux 你支持真彩色
--     TERM = "xterm-256color",
-- }
--
-- -- 默认直接启动 tmux
-- config.default_prog = { "/usr/local/bin/tmux", "-u" } -- -u 强制开启 UTF-8 支持
--
-- -- 1. 确保 Tab Bar 在顶部且样式极简
-- config.tab_bar_at_bottom = false
-- config.use_fancy_tab_bar = false
-- config.hide_tab_bar_if_only_one_tab = false -- 必须设为 false，否则单 Tab 时没地方双击
--
-- -- 2. 隐藏 Tab 上的文字，使其变成一个纯粹的“功能条”
-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--     return {
--         { Text = " " }, -- 只留一个空格，不显示标题
--     }
-- end)
--
-- -- 3. 鼠标绑定：顶部双击全屏
-- config.mouse_bindings = {
--     -- 专门针对顶栏（TabBar）区域的双击
--     {
--         event = { Up = { streak = 2, button = "Left" } },
--         mods = "NONE",
--         -- 核心：判定点击是否发生在 TabBar
--         action = wezterm.action_callback(function(window, pane)
--             local info = window:active_tab():get_title()
--             -- 只要点击没有落入 pane 内部（即没有选词动作），通常就是点击了边框或顶栏
--             window:perform_action(act.ToggleFullScreen, pane)
--         end),
--     },
--     -- 右键粘贴（建议也改用 Up，防止 Down 触发后干扰）
--     {
--         event = { Up = { streak = 1, button = "Right" } },
--         mods = "NONE",
--         action = act.PasteFrom("Clipboard"),
--     },
-- }
--
-- -- 4. 视觉调优：让顶部条与 Tokyo Night 完美融合
-- config.colors = {
--     tab_bar = {
--         background = "rgba(0, 0, 0, 0)", -- 完全透明背景
--         active_tab = { bg_color = "#7aa2f7", fg_color = "#7aa2f7" }, -- 激活状态显示为一段蓝条
--         inactive_tab = { bg_color = "rgba(0, 0, 0, 0)", fg_color = "rgba(0, 0, 0, 0)" },
--     },
-- }
--
-- return config

-- local wezterm = require("wezterm")
-- local act = wezterm.action

-- return {
--     -- =========================
--     -- 字体（事实标准）
--     -- =========================
--     font = wezterm.font_with_fallback({
--         "JetBrains Mono",
--         "Symbols Nerd Font Mono",
--     }),
--     font_size = 12.5,

--     -- =========================
--     -- 外观（主流）
--     -- =========================
--     color_scheme = "Tokyo Night",
--     window_background_opacity = 0.86,
--     macos_window_background_blur = 20,

--     -- =========================
--     -- Tab 行为（极简派）
--     -- =========================
--     hide_tab_bar_if_only_one_tab = true,
--     use_fancy_tab_bar = false,
--     tab_bar_at_bottom = false,

--     -- =========================
--     -- 光标
--     -- =========================
--     default_cursor_style = "BlinkingBar",
--     cursor_blink_rate = 800,

--     -- =========================
--     -- 行为
--     -- =========================
--     scrollback_lines = 10000,
--     enable_scroll_bar = false,
--     audible_bell = "Disabled",

--     -- =========================
--     -- macOS 键位（像 iTerm）
--     -- =========================
--     keys = {
--         { key = "c", mods = "CMD", action = act.CopyTo("Clipboard") },
--         { key = "v", mods = "CMD", action = act.PasteFrom("Clipboard") },
--         { key = "t", mods = "CMD", action = act.SpawnTab("CurrentPaneDomain") },
--         { key = "w", mods = "CMD", action = act.CloseCurrentTab({ confirm = true }) },
--         { key = "Enter", mods = "CMD", action = act.SpawnWindow },
--     },

--     -- =========================
--     -- 剪贴板（tmux 友好）
--     -- =========================
--     set_environment_variables = {
--         TERM = "wezterm",
--     },

--     -- =========================
--     -- 默认 Shell
--     -- =========================
--     default_prog = { "/usr/local/bin/tmux", "-l" },
-- }
-- local wezterm = require("wezterm")
--
-- local config = {}
--
-- -- 字体
-- config.font = wezterm.font_with_fallback({
--     "JetBrainsMono Nerd Font",
--     "Symbols Nerd Font",
-- })
-- config.font_size = 13.5
--
-- -- 窗口透明 + macOS 毛玻璃
-- config.window_background_opacity = 0.80
-- config.macos_window_background_blur = 20
--
-- -- 主题
-- config.color_scheme = "Catppuccin Mocha"
--
-- -- 去掉顶部标题栏
-- -- config.window_decorations = "RESIZE"
--
-- -- 标签栏
-- config.hide_tab_bar_if_only_one_tab = true
-- config.use_fancy_tab_bar = false
--
-- -- 光标 & 选择颜色
-- config.colors = {
--     cursor_bg = "#cdd6f4",
--     cursor_fg = "#1e1e2e",
--     cursor_border = "#cdd6f4",
--     selection_fg = "#cdd6f4",
--     selection_bg = "#45475a",
-- }
--
-- -- 右下角状态显示主题
-- wezterm.on("update-right-status", function(window)
--     window:set_right_status(wezterm.format({
--         { Text = " ☕ Catppuccin Mocha " },
--     }))
-- end)
--
-- -- 双击放大 Pane (Ctrl+Shift+Z)
-- config.keys = {
--     { key = "|", mods = "CTRL|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
--     { key = "-", mods = "CTRL|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
--     { key = "h", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
--     { key = "l", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
--     { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
--     { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
--     { key = "z", mods = "CTRL|SHIFT", action = wezterm.action.TogglePaneZoomState },
--     { key = "R", mods = "CTRL|SHIFT", action = wezterm.action.ReloadConfiguration },
-- }
--
-- return config
-- local wezterm = require 'wezterm'
-- local act = wezterm.action

-- return {
--   -- 字体（强烈推荐）
--   font = wezterm.font_with_fallback({
--     "JetBrains Mono",
--     "Symbols Nerd Font Mono",
--   }),
--   font_size = 13.0,

--   -- 外观
--   color_scheme = "Tokyo Night",
--   window_background_opacity = 0.86,
--   macos_window_background_blur = 20,

--   -- Tab
--   hide_tab_bar_if_only_one_tab = true,
--   use_fancy_tab_bar = false,

--   -- 光标
--   default_cursor_style = "BlinkingBar",
--   cursor_blink_rate = 800,

--   -- 行为
--   scrollback_lines = 10000,
--   enable_scroll_bar = false,

--   -- 剪贴板（关键！）
--   enable_wayland = false,
--   send_composed_key_when_left_alt_is_pressed = true,

--   -- macOS 复制行为
--   keys = {
--     -- Cmd+C / Cmd+V 直通系统
--     { key = "c", mods = "CMD", action = act.CopyTo "Clipboard" },
--     { key = "v", mods = "CMD", action = act.PasteFrom "Clipboard" },

--     -- Cmd+Enter 新窗口
--     { key = "Enter", mods = "CMD", action = act.SpawnWindow },
--   },

--   -- 默认 Shell（交给 tmux）
--   default_prog = { "/usr/local/bin/tmux", "-l" },
--   -- 性能优化
--   config.front_end = "WebGpu" -- macOS 上 WebGpu/Metal 性能极佳
-- }
