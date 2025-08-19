local add, later = MiniDeps.add, MiniDeps.later

later(function()
  add({ source = "MeanderingProgrammer/render-markdown.nvim", depends = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' } })
  local markdown = require('render-markdown')
  markdown.setup({ completions = { blink = { enabled = true } } })
end)

later(function()
  add({ source = "obsidian-nvim/obsidian.nvim" })
  local obsidian = require('obsidian')
  obsidian.setup({
    legacy_commands = false,
    completion = {
      nvim_cmp = false,
      blink = true,
    },
    picker = {
      name = 'snacks.pick',
    },
    workspaces = {
      {
        name = "personal",
        path = "/mnt/backup/Documents/study/erudhirVault/",
      },
    },
  })
end)
