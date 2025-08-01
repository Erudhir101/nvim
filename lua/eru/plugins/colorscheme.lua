local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add({ source = "folke/tokyonight.nvim" })
  vim.cmd("colorscheme tokyonight-night")
end)
