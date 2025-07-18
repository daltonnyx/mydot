-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- Clipboard
local opt = vim.opt
opt.title = true

-- Ignore whitespace in diff mode
opt.diffopt:append("iwhite")

-- Lines of context
opt.scrolloff = 8

opt.laststatus = 3

if vim.env.SSH_TTY then
  opt.clipboard:append("unnamedplus")
  -- local function paste()
  --   return vim.split(vim.fn.getreg(""), "\n")
  -- end
  -- vim.g.clipboard = {
  --   name = "OSC 52",
  --   copy = {
  --     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
  --     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  --   },
  --   paste = {
  --     ["+"] = paste,
  --     ["*"] = paste,
  --   },
  -- }
end
vim.g.mkdp_theme = "light"
vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/lua/extras/markdown-preview.css")
