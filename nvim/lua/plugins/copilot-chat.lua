return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
      window = {
        layout = "float",
        relative = "cursor",
        width = 0.8,
        height = 0.8,
        row = 1,
      },
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
