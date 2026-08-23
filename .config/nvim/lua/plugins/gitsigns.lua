return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      -- Show git blame as faded virtual text at the end of the current line,
      -- updating as the cursor moves (GitLens-style).
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 300,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
    },
  },
}
