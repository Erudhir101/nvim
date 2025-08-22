local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
  add({ source = "ibhagwan/fzf-lua", depends = { "echasnovski/mini.icons" } })
  local fzf = require("fzf-lua")

  fzf.setup({
    files = {
      cmd = "rg --files --hidden -n --column --follow --glob '!.git' --ignore-file $HOME/.config/nvim/vim-ignore"
    },
    grep = {
      rg_opts = "--hidden -n --column --follow --glob '!.git' --ignore-file $HOME/.config/nvim/vim-ignore"
    }
  })
  vim.ui.select = fzf.register_ui_select

  --keymaps from ui
  fzf.config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
  fzf.config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"

  local map = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { desc = desc })
  end

  map(";b", function() fzf.buffers() end, "Fzf Buffers")
  map(";d", function() fzf.diagnostics_document() end, "Fzf Diagnostics")
  map(";D", function() fzf.diagnostics_workspace() end, "Fzf Diagnostics (workspace)")
  map(";f", function() fzf.files() end, "Fzf Files")
  map(";g", function() fzf.live_grep() end, "Fzf Live Grep")
  map(";h", function() fzf.help_tags() end, "Fzf Help")
  map(";k", function() fzf.keymaps() end, "Fzf Keymaps")
  map(";t", function() fzf.tags() end, "Fzf Tags")
  map(";T", function() fzf.grep({ search = "TODO|HACK|NOTE|FIX", no_esc = true }) end, "Fzf Hippatter")
  map(";z", function() fzf.spell_suggest() end, "Fzf Spell suggestions")
end)
