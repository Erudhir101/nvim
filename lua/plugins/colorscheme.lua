return {
  {
    "catppuccin/nvim",
    lazy = true,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      local status, colorTheme = pcall(require, "catppuccin")
      if not status then
        return
      end
      colorTheme.setup({
        -- flavour = "latte",
        -- transparent_background = true,
        integrations = {
          aerial = true,
          alpha = true,
          cmp = true,
          dashboard = true,
          flash = true,
          gitsigns = true,
          headlines = true,
          illuminate = true,
          indent_blankline = { enabled = true },
          leap = true,
          lsp_trouble = true,
          mason = true,
          markdown = true,
          mini = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "undercurl" },
              hints = { "undercurl" },
              warnings = { "undercurl" },
              information = { "undercurl" },
            },
          },
          navic = { enabled = true, custom_bg = "lualine" },
          neotest = true,
          neotree = true,
          noice = true,
          notify = true,
          semantic_tokens = true,
          telescope = true,
          treesitter = true,
          treesitter_context = true,
          which_key = true,
        },
      })
    end,
  },
  -- {
  --   "craftzdog/solarized-osaka.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   config = function()
  --     local status, theme = pcall(require, "solarized-osaka")
  --     if not status then
  --       return
  --     end
  --     theme.setup({ transparent = false })
  --   end,
  -- },
}
