return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		--"nvim-tree/nvim-web-devicons",
	},
	event = { "VimEnter" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.load_extension("fzf")

		telescope.setup({
			defaults = {
				path_display = { "truncate" },
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
				vimpgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
				},
				file_ignore_patterns = {
					"node_modules/",
					"%.git/",
					"%.DS_Store$",
					"target/",
					"build/",
					"%.o$",
				},
				color_devicons = true,
			},
			pickers = {
				find_files = { hidden = true },
				live_grep = {
					-- @usage don't include the filename in the search results
					only_sort_text = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", ";f", function()
			builtin.find_files({})
		end)
		keymap.set("n", ";r", function()
			builtin.live_grep()
		end)
		keymap.set("n", ";b", function()
			builtin.buffers()
		end)
		keymap.set("n", ";t", function()
			builtin.help_tags()
		end)
		keymap.set("n", ";;", function()
			builtin.resume()
		end)
		keymap.set("n", ";e", function()
			builtin.diagnostics()
		end)
	end,
}
