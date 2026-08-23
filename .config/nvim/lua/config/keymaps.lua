-- Keymaps
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Write shortcut (mirrors .vimrc C-s)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Disable accidental Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Buffer navigation via bufferline (gt/gT are tabpage-native, unused with buffline)
vim.keymap.set("n", "gt", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "gT", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })
