-- Make Python LSPs resolve imports from the project's uv-managed .venv.
-- Pyright doesn't auto-discover .venv; without this it uses whatever python is
-- on PATH (devbox/system), so every third-party import shows as unresolved.
local function use_project_venv(_, config)
  local root = config.root_dir or vim.uv.cwd()
  local python = root .. "/.venv/bin/python"
  if vim.uv.fs_stat(python) then
    config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
      python = { pythonPath = python },
    })
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Only the one selected by LazyVim's python extra is enabled; the
        -- others keep their `enabled = false` when merged.
        pyright = { before_init = use_project_venv },
        basedpyright = { before_init = use_project_venv },
      },
    },
  },
}
