-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

vim.keymap.set("n", "<leader>gb", ":Git blame_line<CR>", { desc = "Blame this line" })
vim.keymap.set("n", "<leader>gB", function()
  local Util = require("lazyvim.util")
  -- local util = require("lazy.util")
  Util.terminal({ "tig", "blame", vim.fn.expand("%") }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false })
end, { desc = "Open tig blame" })

vim.keymap.set("n", "<leader>wc", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
