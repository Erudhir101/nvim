local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add({ source = "folke/lazydev.nvim" })
  require("lazydev").setup({ library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } })
end)

later(function()
  add({ source = "folke/which-key.nvim" })
  require("which-key").setup({ preset = "helix" })
end)

later(function()
  add({ source = "folke/flash.nvim" })
  local flash = require("flash")

  flash.setup({
    search = {
      mode = "search",
    },
    char = {
      enabled = false,
    },
  })

  vim.keymap.set({ "n", "x", "o" }, "s", function()
    flash.jump()
  end, { desc = "flash Jump" })
  vim.keymap.set({ "n", "x", "o" }, ";s", function()
    flash.treesitter()
  end, { desc = "flash Treesitter" })
end)

now(function()
  add({ source = "folke/snacks.nvim" })
  local snacks = require("snacks")

  snacks.setup({
    bigfile = { enabled = true, notify = true, size = 100 * 1024 },
    image = { enabled = true },
    indent = { enabled = true, animate = { enabled = false } },
    lazygit = { enabled = true },
    input = { enabled = false },
    notifier = { enabled = true },
    quickfile = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { section = "keys",  gap = 1, padding = 1 },
      },
      preset = {
        keys = {
          {
            icon = " ",
            key = "f",
            desc = "Find File",
            action = ":FzfLua files",
          },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          {
            icon = " ",
            key = "g",
            desc = "Find Text",
            action = ":FzfLua live_grep",
          },
          {
            icon = " ",
            key = "r",
            desc = "Recent Files",
            action = ":FzfLua oldfiles",
          },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":FzfLua files cwd vim.fn.stdpath('config')",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
    },
  })
end)
