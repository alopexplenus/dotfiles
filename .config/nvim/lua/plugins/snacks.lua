return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- Apply to every picker source (files, grep, explorer, ...)
        hidden = true, -- show hidden (dot) files, e.g. .env, .gitconfig
        ignored = true, -- also show git-ignored files, e.g. node_modules
      },
    },
  },
}
