local add, now = MiniDeps.add, MiniDeps.now

now(function()
  add({
    source = "nvim-treesitter/nvim-treesitter",
    checkout = "master",
    monitor = "main",
    hooks = { post_checkout = vim.cmd.TSUpdate },
  })

  require("nvim-treesitter.configs").setup({
    sync_install = false,
    modules = {},
    ignore_install = {},
    highlight = { enable = true },
    auto_install = false,
    indent = { enable = true },
    autotag = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "css",
      "dockerfile",
      "gitignore",
      "go",
      "html",
      "java",
      "javascript",
      "json",
      "lua",
      "markdown",
      "markdown_inline",
      "prisma",
      "python",
      "rust",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "yaml",
    },
  })
end)
