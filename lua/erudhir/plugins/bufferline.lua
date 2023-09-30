return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPre", "BufNewFile" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "thin",
		},
	},
}
