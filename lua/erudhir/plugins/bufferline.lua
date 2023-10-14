return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	version = "*",
	opts = {
		options = {
			mode = "tabs",
			separator_style = "thin",
		},
	},
}
