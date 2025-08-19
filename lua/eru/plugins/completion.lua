local add, now = MiniDeps.add, MiniDeps.now

local function build_blink(params)
  vim.notify("Building blink.cmp", vim.log.levels.INFO)
  local obj = vim.system({ "cargo", "build", "--release" }, { cwd = params.path }):wait()
  if obj.code == 0 then
    vim.notify("Building blink.cmp done", vim.log.levels.INFO)
  else
    vim.notify("Building blink.cmp failed", vim.log.levels.ERROR)
  end
end

now(function()
  add({
    source = "saghen/blink.cmp",
    depends = { "rafamadriz/friendly-snippets", "echasnovski/mini.icons" },
    -- checkout = "1.6.0",
    hooks = {
      post_install = build_blink,
      post_checkout = build_blink,
    },
  })
  local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
  require("blink.cmp").setup({
    keymap = { preset = "default", ["<C-y>"] = { "accept", "fallback" } },
    appearance = {
      nerd_font_variant = "mono",
    },
    fuzzy = { implementation = "lua" },
    completion = {
      keyword = { range = "full" },
      menu = {
        auto_show = true,
        border = border,
        draw = {
          columns = {
            { "kind_icon", "kind",              gap = 1 },
            { "label",     "label_description", gap = 1 },
          },
          components = {
            kind_icon = {
              text = function(ctx)
                local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                return kind_icon
              end,
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
            kind = {
              highlight = function(ctx)
                local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                return hl
              end,
            },
          },
        },
      },
      documentation = {
        window = {
          border = border,
        },
        auto_show = true,
      },
      trigger = {
        show_on_keyword = true,
      },
    },
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
      },
    },
  })
end)
