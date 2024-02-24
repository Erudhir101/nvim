return {
	{ "nvim-lua/plenary.nvim" },
	{ "christoomey/vim-tmux-navigator" },
	{
		"jsongerber/nvim-px-to-rem",
		event = "CmdlineLeave",
		config = function()
			local status, pxToRem = pcall(require, "nvim-px-to-rem")
			if not status then
				return
			end
			pxToRem.setup()
		end,
	},
	{
		"nvim-zh/better-escape.vim",
		event = { "InsertEnter" },
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash Jump",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
		},
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 500
		end,
	},
}
