return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	branch = "0.1.x",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		-- { "nvim-telescope/telescope-file-browser.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-telescope/telescope-symbols.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local status, telescope = pcall(require, "telescope")
		if not status then
			return
		end

		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		local function telescope_buffer_dir()
			return vim.fn.expand("%:p:h")
		end

		-- local fb_actions = telescope.extensions.file_browser.actions

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				file_ignore_patterns = {
					"%.7z",
					"%.burp",
					"%.bz2",
					"%.cache",
					"%.class",
					"%.dll",
					"%.docx",
					"%.dylib",
					"%.epub",
					"%.exe",
					"%.flac",
					"%.ico",
					"%.ipynb",
					"%.jar",
					"%.lock",
					"%.met",
					"%.mkv",
					"%.mp4",
					"%.otf",
					"%.pdb",
					"%.pdf",
					"%.rar",
					"%.sqlite3",
					"%.svg",
					"%.tar",
					"%.tar.gz",
					"%.ttf",
					"%.webp",
					"%.zip",
					".dart_tool/",
					".git/",
					".github/",
					".gradle/",
					".idea/",
					".settings/",
					".vale/",
					".vscode/",
					"__pycache__/",
					"__pycache__/*",
					"build/",
					"docs/",
					"env/",
					"gradle/",
					"node_modules/",
					"node_modules/*",
					"smalljre_*/*",
					"target/",
					"vendor/*",
					-- "%.jpeg",
					-- "%.jpg",
					-- "%.png",
				},
				mappings = {
					i = {
						-- ["<C-k>"] = actions.move_selection_previous, -- move to prev result
						-- ["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.close,
					},
					n = {
						["<C-q>"] = actions.close,
					},
				},
			},
			dynamic_preview_title = true,
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			layout_config = {
				horizontal = {
					preview_cutoff = 100,
					preview_width = 0.5,
				},
			},
		})

		telescope.load_extension("fzf")
		-- telescope.load_extension("file_browser")

		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", ";f", function()
			builtin.find_files({ no_ignore = false, hidden = true })
		end, { desc = "Fuzzy find files in cwd" })

		keymap.set("n", ";r", function()
			builtin.resume()
		end, { desc = "Fuzzy find recent files" })

		keymap.set("n", ";g", function()
			builtin.live_grep()
		end, { desc = "Find string in cwd" })

		keymap.set("n", ";t", function()
			builtin.help_tags()
		end, { desc = "Find tags in files" })

		keymap.set("n", ";d", function()
			builtin.diagnostics()
		end, { desc = "Find all diagnostics" })

		keymap.set("n", ";b", function()
			builtin.buffers()
		end, { desc = "Find all buffers" })

		-- keymap.set("n", ";e", function()
		-- 	telescope.extensions.file_browser.file_browser({
		-- 		path = "%:p:h",
		-- 		cwd = telescope_buffer_dir(),
		-- 		respect_gitignore = false,
		-- 		hidden = true,
		-- 		grouped = true,
		-- 		previewer = false,
		-- 		initial_mode = "insert",
		-- 		layout_config = { height = 40 },
		-- 	})
		-- end, { desc = "Open File Browser" })
	end,
}
