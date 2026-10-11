-- Keymaps
-- LazyVim defaults: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

-- Write shortcut (mirrors .vimrc C-s)
vim.keymap.set({ "n", "i", "v" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- Disable accidental Ex mode
vim.keymap.set("n", "Q", "<nop>")

-- Buffer navigation via bufferline (gt/gT are tabpage-native, unused with buffline)
vim.keymap.set("n", "gt", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "gT", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previous buffer" })

-- :q / :wq close the current buffer instead of the window (bufferline workflow).
-- Falls back to real quit for special windows (help, quickfix, explorer, ...)
-- and when this is the last listed buffer.
local function buf_quit(write, bang)
  local buf = vim.api.nvim_get_current_buf()
  local special = vim.bo[buf].buftype ~= "" or not vim.bo[buf].buflisted
  if write and not special then
    vim.cmd(bang and "write!" or "write")
  end
  local listed = vim.tbl_filter(function(b)
    return vim.bo[b].buflisted
  end, vim.api.nvim_list_bufs())
  if special then
    vim.cmd(bang and "quit!" or "quit")
  elseif #listed <= 1 then
    vim.cmd(bang and "quitall!" or "quitall")
  else
    Snacks.bufdelete({ buf = buf, force = bang })
  end
end

vim.api.nvim_create_user_command("BufQuit", function(o) buf_quit(false, o.bang) end, { bang = true })
vim.api.nvim_create_user_command("BufWriteQuit", function(o) buf_quit(true, o.bang) end, { bang = true })

-- Only expand when the abbreviation is the whole ':' command line, so `:q` inside
-- longer commands (or in / searches) is left alone. `:q!` / `:wq!` pass the bang.
for lhs, rhs in pairs({ q = "BufQuit", wq = "BufWriteQuit" }) do
  vim.cmd(
    ("cnoreabbrev <expr> %s getcmdtype() == ':' && getcmdline() == '%s' ? '%s' : '%s'"):format(lhs, lhs, rhs, lhs)
  )
end
