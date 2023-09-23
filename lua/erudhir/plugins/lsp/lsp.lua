-- return {
--   {
--     "folke/neodev.nvim",
--     event = { "BufReadPre", "BufNewFile" },
--     config = function()
--       local neodev = require("neodev")
--
--       neodev.setup()
--     end,
--   },
--   {
--     "VonHeikemen/lsp-zero.nvim",
--     event = { "BufReadPre", "BufNewFile" },
--     cmd = "Mason",
--     branch = "v2.x",
--     dependencies = {
--       { "neovim/nvim-lspconfig" },
--       {
--         "williamboman/mason.nvim",
--         build = function()
--           require("MasonUpdate")
--         end,
--       },
--       { "williamboman/mason-lspconfig.nvim" },
--
--       { "hrsh7th/nvim-cmp" },
--       { "hrsh7th/cmp-nvim-lsp" },
--       { "L3MON4D3/LuaSnip" },
--       { "SmiteshP/nvim-navic" },
--     },
--     config = function()
--       local lsp = require("lsp-zero").preset({})
--
--       local navic = require("nvim-navic")
--
--       lsp.on_attach(function(client, bufnr)
--         lsp.default_keymaps({ buffer = bufnr })
--         lsp.buffer_autoformat()
--         if client.server_capabilities.documentSymbolProvider then
--           navic.attach(client, bufnr)
--         end
--       end)
--
--       require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
--
--       lsp.ensure_installed({
--         "pyright",
--         "lua_ls",
--         "gopls",
--         "clangd",
--       })
--
--       lsp.setup()
--
--       local cmp = require("cmp")
--       -- local cmp_action = require('lsp-zero').cmp_action()
--
--       require("luasnip.loaders.from_vscode").lazy_load()
--       cmp.setup({
--         preselect = cmp.PreselectMode.None,
--         sources = {
--           { name = "nvim_lsp" },
--           { name = "luasnip" },
--         },
--         mapping = {
--           ["<CR>"] = cmp.mapping.confirm({ select = false }),
--         },
--         window = {
--           completion = cmp.config.window.bordered(),
--           documentation = cmp.config.window.bordered(),
--         },
--         snippet = {
--           expand = function(args)
--             require("luasnip").lsp_expand(args.body)
--           end,
--         },
--       })
--     end,
--   },
--   { "saadparwaiz1/cmp_luasnip" },
--   { "rafamadriz/friendly-snippets" },
--   -- {
--   --     'dgagn/diagflow.nvim',
--   --     opts = {
--   --         -- placement = 'inline',
--   --         scope = 'line',
--   --         padding_right = 5
--   --     }
--   -- }
-- }
return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    lazy = true,
    config = function()
      -- This is where you modify the settings for lsp-zero
      -- Note: autocompletion settings will not take effect

      require('lsp-zero.settings').preset({})
    end
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'L3MON4D3/LuaSnip' },
    },
    config = function()
      -- Here is where you configure the autocompletion settings.
      -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
      -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

      require('lsp-zero.cmp').extend()

      -- And you can configure cmp even more, if you want to.
      local cmp = require('cmp')
      local cmp_action = require('lsp-zero.cmp').action()

      cmp.setup({
        mapping = {
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        }
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = 'LspInfo',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'williamboman/mason.nvim' },
    },
    config = function()
      -- This is where all the LSP shenanigans will live

      local lsp = require('lsp-zero')

      lsp.on_attach(function(client, bufnr)
        -- see :help lsp-zero-keybindings
        -- to learn the available actions
        lsp.default_keymaps({ buffer = bufnr })
      end)

      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

      lsp.setup()
    end
  }
}
