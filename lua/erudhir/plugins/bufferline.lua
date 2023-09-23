return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = "nvim-tree/nvim-web-devicons",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local bufferline = require("bufferline")

		bufferline.setup({
			options = {
				mode = "tabs",
				separator_style = "slant",
				always_show_bufferline = false,
				show_buffer_close_icons = false,
				show_close_icon = false,
				color_icons = true,
			},
			highlights = {
				separator = {
					fg = "#073642",
					bg = "#002b36",
				},
				separator_selected = {
					fg = "#073642",
				},
				background = {
					fg = "#657b83",
					bg = "#002b36",
				},
				buffer_selected = {
					fg = "#fdf6e3",
					bold = true,
				},
				fill = {
					bg = "#073642",
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", {})
		keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", {})
	end,
}
