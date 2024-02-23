return {
  {
    enabled = true,
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      -- labels = "#abcdef",
      modes = {
        -- char = { jump_labels = false },
        -- treesitter = {
        --   label = {
        --     rainbow = { enabled = true },
        --   },
        -- },
        treesitter_search = {
          label = {
            rainbow = { enabled = true },
            -- format = function(opts)
            --   local label = opts.match.label
            --   if opts.after then
            --     label = label .. ">"
            --   else
            --     label = "<" .. label
            --   end
            --   return { { label, opts.hl_group } }
            -- end,
          },
        },
      },
      -- search = { mode = "fuzzy" },
      -- labels = "😅😀🏇🐎🐴🐵🐒",
    },
    keys = {
      {
        ";s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash Jump",
      },
      {
        ";S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
    },
  },
  {

    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
      filesystem = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every
        },
        -- time the current file is changed while the tree is open.
        group_empty_dirs = true, -- when true, empty folders will be grouped together
        hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
      },
    },
  },

  {
    "dinhhuy258/git.nvim",
    event = "BufReadPre",
    opts = {
      keymaps = {
        -- Open blame window
        blame = "<Leader>gb",
        -- Open file/folder in git repository
        browse = "<Leader>go",
      },
    },
  },

  {
    "telescope.nvim",
    dependencies = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    keys = {
      {
        "<leader>fP",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
      {
        ";f",
        function()
          require("telescope.builtin").find_files({
            no_ignore = false,
            hidden = true,
          })
        end,
        desc = "Lists files in your current working directory, respects .gitignore",
      },
      {
        ";g",
        function()
          require("telescope.builtin").live_grep({
            additional_args = { "--hidden" },
          })
        end,
        desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
      },
      {
        ";b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Lists open buffers",
      },
      {
        ";t",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
      },
      {
        ";r",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume the previous telescope picker",
      },
      {
        ";d",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Lists Diagnostics for all open buffers or a specific buffer",
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")

      opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.5,
          },
          width = 0.8,
          height = 0.8,
          preview_cutoff = 120,
        },
        sorting_strategy = "ascending",
        winblend = 0,
      })
      telescope.setup(opts)
      require("telescope").load_extension("fzf")
    end,
  },
}
