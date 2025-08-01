local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

later(function()
  add("echasnovski/mini.comment")
  require("mini.comment").setup()
end)

later(function()
  add("echasnovski/mini.diff")
  require("mini.diff").setup({ view = { style = "sign" } })
end)

later(function()
  add("echasnovski/mini.move")
  require("mini.move").setup()
end)

later(function()
  add("echasnovski/mini.pairs")
  require("mini.pairs").setup({
    modes = { insert = true, command = false, terminal = false }
  })
end)

now(function()
  add("echasnovski/mini.icons")
  require("mini.icons").setup()
end)

later(function()
  add("echasnovski/mini.cursorword")
  require("mini.cursorword").setup()
end)

later(function()
  add("echasnovski/mini.keymap")

  local map_combo = require("mini.keymap").map_combo
  local mode = { "i", "c", "x", "s" }

  map_combo(mode, "jk", "<BS><BS><Esc>")
  -- Escape into Normal mode from Terminal mode
  map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
end)

later(function()
  add("echasnovski/mini.bracketed")

  require("mini.bracketed").setup({
    buffer = { suffix = "b", options = {} }, -- using cybu
    comment = { suffix = "c", options = {} },
    conflict = { suffix = "x", options = {} },
    -- don't want diagnostic float focus, have in mappings.lua with coc
    -- support too
    diagnostic = { suffix = "d", options = {} },
    file = { suffix = "", options = {} },
    indent = { suffix = "", options = {} }, -- confusing
    jump = { suffix = "", options = {} },   -- redundant
    location = { suffix = "", options = {} },
    oldfile = { suffix = "", options = {} },
    quickfix = { suffix = "q", options = {} },
    treesitter = { suffix = "t", options = {} },
    undo = { suffix = "", options = {} },
    window = { suffix = "", options = {} }, -- broken going to unlisted
    yank = { suffix = "", options = {} },   -- confusing
  })
end)

later(function()
  add("echasnovski/mini.surround")

  require("mini.surround").setup({
    mappings = {
      add = "<leader>sa",     -- Add surrounding in Normal and Visual modes
      delete = "<leader>sd",  -- Delete surrounding
      find = "",              -- Find surrounding (to the right)
      find_left = "",         -- Find surrounding (to the left)
      highlight = "",         -- Highlight surrounding
      replace = "<leader>sr", -- Replace surrounding
      update_n_lines = "",    -- Update `n_lines`

      suffix_last = "",       -- Suffix to search with "prev" method
      suffix_next = "",       -- Suffix to search with "next" method
    },
  })
end)

later(function()
  add({ source = "echasnovski/mini.statusline", depends = { "echasnovski/mini.icons" } })

  local line = require("mini.statusline")

  line.setup({
    content = {
      active = function()
        local mode, mode_hl = line.section_mode({ trunc_width = 120 })
        local git = line.section_git({ trunc_width = 40 })
        local diff = line.section_diff({ trunc_width = 75 })
        local diagnostics = line.section_diagnostics({ trunc_width = 75 })
        local lsp = line.section_lsp({ trunc_width = 75 })
        local filename = line.section_filename({ trunc_width = 140 })
        local fileinfo = line.section_fileinfo({ trunc_width = 120 })
        local search = line.section_searchcount({ trunc_width = 75 })

        return line.combine_groups({
          { hl = mode_hl,                 strings = { mode } },
          { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
          "%<", -- Mark general truncate point
          { hl = "MiniStatuslineFilename", strings = { filename } },
          "%=", -- End left alignment
          { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
          { hl = mode_hl,                  strings = { search, "%P %l:%c" } },
        })
      end,
    },
  })
end)

later(function()
  add({ source = "echasnovski/mini.files", depends = { "echasnovski/mini.icons" } })
  local MiniFiles = require("mini.files")
  MiniFiles.setup({
    mappings = {
      close = "q",
      go_in = "l",
      go_in_plus = "L",
      go_out = "h",
      go_out_plus = "H",
      mark_goto = "'",
      mark_set = "m",
      reset = ",",
      reveal_cwd = "?",
      show_help = "g?",
      synchronize = "=",
      trim_left = "<",
      trim_right = ">",
    },
  })

  local minifiles_toggle = function(...)
    if not MiniFiles.close() then
      MiniFiles.open(...)
    end
  end

  vim.keymap.set("n", "<leader>e", function()
    local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
    minifiles_toggle(path)
  end, { desc = "Open mini.files (cwd)" })
end)
