return {
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        expand = function(snippet, _)
          return LazyVim.cmp.expand(snippet)
        end,
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = false,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          -- experimental auto-brackets support
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },

      -- experimental signature help support
      -- signature = { enabled = true },

      sources = {
        -- adding any nvim-cmp sources here will enable them
        -- with blink.compat
        compat = { "avante_commands", "avante_mentions", "avante_files" },
        default = { "lsp", "path", "snippets", "buffer" },
      },

      keymap = {
        preset = "super-tab",
        ["<C-y>"] = { "select_and_accept" },
      },
    },
  },
  {
    "saghen/blink.compat",
    lazy = true,
    opts = {},
    config = function()
      -- monkeypatch cmp.ConfirmBehavior for Avante
      require("cmp").ConfirmBehavior = {
        Insert = "insert",
        Replace = "replace",
      }
    end,
  },
}
-- return {
--   "hrsh7th/nvim-cmp",
--   opts = function(_, opts)
--     local cmp = require("cmp")
--     -- local luasnip = require("luasnip")
--     local has_words_before = function()
--       unpack = unpack or table.unpack
--       local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--       return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
--     end
--
--     -- opts.preselect = cmp.PreselectMode.None
--     opts.completion = {
--       completeopt = "menu,menuone,noinsert,noselect",
--     }
--
--     opts.mapping = vim.tbl_extend("force", opts.mapping, {
--       ["<CR>"] = cmp.config.disable,
--       ["<Tab>"] = cmp.mapping.confirm({ select = true }),
--       ["<Ctr-n>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_next_item()
--           -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--           -- this way you will only jump inside the snippet region
--           -- elseif luasnip.expand_or_jumpable() then
--           --   luasnip.expand_or_jump()
--         elseif has_words_before() then
--           cmp.complete()
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       ["<Ctr-p>"] = cmp.mapping(function(fallback)
--         if cmp.visible() then
--           cmp.select_prev_item()
--         -- elseif luasnip.jumpable(-1) then
--         --   luasnip.jump(-1)
--         else
--           fallback()
--         end
--       end, { "i", "s" }),
--       -- ["<CR>"] = cmp.mapping.confirm({ select = false }),
--       -- ["<Tab>"] = cmp.mapping(function(fallback)
--       --   if cmp.visible() then
--       --     cmp.select_next_item()
--       --     -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
--       --     -- they way you will only jump inside the snippet region
--       --   elseif luasnip.expand_or_jumpable() then
--       --     luasnip.expand_or_jump()
--       --   elseif has_words_before() then
--       --     cmp.complete()
--       --   else
--       --     fallback()
--       --   end
--       -- end, { "i", "s" }),
--       -- ["<S-Tab>"] = cmp.mapping(function(fallback)
--       --   if cmp.visible() then
--       --     cmp.select_prev_item()
--       --   elseif luasnip.jumpable(-1) then
--       --     luasnip.jump(-1)
--       --   else
--       --     fallback()
--       --   end
--       -- end, { "i", "s" }),
--     })
--   end,
-- }
