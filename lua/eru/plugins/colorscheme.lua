local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add({ source = "folke/tokyonight.nvim" })
  require("tokyonight").setup({
    on_colors = function(colors)
      colors.bg_float = "#0a0a0a"
      colors.bg = "#0a0a0a"
    end
  })
  vim.cmd("colorscheme tokyonight-night")
end)

-- now(function()
--   add({ source = "catppuccin/nvim", name = "catppuccin" })
--   require("catppuccin").setup({
--     term_colors = true,
--     color_overrides = {
--       mocha = {
--         base = "#0a0a0a",
--         mantle = "#0a0a0a",
--         crust = "#0a0a0a",
--       }
--     }
--   })
--   vim.cmd("colorscheme catppuccin-mocha")
-- end)
