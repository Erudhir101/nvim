return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          ["not"] = {
            event = "lsp",
            kind = "progress",
          },
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }
      -- opts.status = { lsp_progress = { event = "lsp", kind = "progress" } }
      opts.presets.lsp_doc_border = true

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      render = "compact",
      background_colour = "#000000",
      stages = "fade",
      timeout = 2000,
    },
  },

  -- animations
  {
    enabled = false,
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },

  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        -- separator_style = "slant",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = false,
        theme = "catppuccin",
        -- theme = "solarized-osaka",
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
███████ ██████  ██    ██ ██████  ██   ██ ██ ██████  
██      ██   ██ ██    ██ ██   ██ ██   ██ ██ ██   ██ 
█████   ██████  ██    ██ ██   ██ ███████ ██ ██████  
██      ██   ██ ██    ██ ██   ██ ██   ██ ██ ██   ██ 
███████ ██   ██  ██████  ██████  ██   ██ ██ ██   ██ 
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
