-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.cmd.colorscheme("catppuccin-macchiato")
-- Disable autoformat for markdown files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "md" },
  callback = function()
    vim.b.autoformat = false
  end,
})
