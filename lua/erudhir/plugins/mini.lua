return {
	{ "echasnovski/mini.bracketed", version = false, config = true },
	{
		"echasnovski/mini.surround",
		version = false,
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},
	-- { "echasnovski/mini.hipatterns", version = false , config = true},
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	version = false, -- wait till new 0.7.0 release to put it back on semver
	-- 	event = { "BufReadPost", "BufNewFile", "BufWritePre" },
	-- 	opts = {
	-- 		-- symbol = "▏",
	-- 		symbol = "│",
	-- 		options = { try_as_border = true },
	-- 	},
	-- 	init = function()
	-- 		vim.api.nvim_create_autocmd("FileType", {
	-- 			pattern = {
	-- 				"help",
	-- 				"alpha",
	-- 				"dashboard",
	-- 				"tree",
	-- 				"Trouble",
	-- 				"trouble",
	-- 				"lazy",
	-- 				"mason",
	-- 				"notify",
	-- 				"toggleterm",
	-- 				"lazyterm",
	-- 			},
	-- 			callback = function()
	-- 				vim.b.miniindentscope_disable = true
	-- 			end,
	-- 		})
	-- 	end,
	-- },
}
