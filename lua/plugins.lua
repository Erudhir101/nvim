-- Clone 'mini.deps' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath("data") .. "/site/"
local mini_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing `mini.deps`" | redraw')
	local clone_cmd = {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/echasnovski/mini.deps",
		mini_path,
	}
	vim.fn.system(clone_cmd)
	vim.cmd("packadd mini.deps | helptags ALL")
	vim.cmd('echo "Installed `mini.deps`" | redraw')
end

-- Set up 'mini.deps' (customize to your liking)
require("mini.deps").setup({ path = { package = path_package } })

local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

now(function()
	add({ source = "folke/tokyonight.nvim" })
	vim.cmd("colorscheme tokyonight-night")
end)

later(function()
	add({ source = "folke/lazydev.nvim" })
	require("lazydev").setup({ library = { { path = "${3rd}/luv/library", words = { "vim%.uv" } } } })
end)

later(function()
	add({ source = "folke/which-key.nvim" })
	require("which-key").setup({ preset = "helix" })
end)

later(function()
	add({ source = "folke/flash.nvim" })
	local flash = require("flash")

	flash.setup({
		search = {
			mode = "search",
		},
		char = {
			enabled = false,
		},
	})

	vim.keymap.set({ "n", "x", "o" }, "s", function()
		flash.jump()
	end, { desc = "flash Jump" })
	vim.keymap.set({ "n", "x", "o" }, ";s", function()
		flash.treesitter()
	end, { desc = "flash Treesitter" })
end)

now(function()
	add({ source = "folke/snacks.nvim" })
	local snacks = require("snacks")

	snacks.setup({
		bigfile = { enabled = true, notify = true, size = 100 * 1024 },
		image = { enabled = true },
		indent = { enabled = true, animate = { enabled = false } },
		lazygit = { enabled = true },
		input = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = false },
		scroll = { enabled = false },
		statuscolumn = { enabled = false },
		words = { enabled = false },
		dashboard = {
			enabled = true,
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
			},
			preset = {
				keys = {
					{
						icon = " ",
						key = "f",
						desc = "Find File",
						action = ":lua Snacks.dashboard.pick('files')",
					},
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{
						icon = " ",
						key = "g",
						desc = "Find Text",
						action = ":lua Snacks.dashboard.pick('live_grep')",
					},
					{
						icon = " ",
						key = "r",
						desc = "Recent Files",
						action = ":lua Snacks.dashboard.pick('oldfiles')",
					},
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
					},
					{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
		},
		picker = {
			enabled = true,
			excludes = { ".git", "node_modules" },
			auto_close = true,
			sources = {},
		},
	})

	vim.keymap.set("n", "<leader>lg", function()
		snacks.lazygit()
	end, { desc = "Lazygit open" })

	vim.keymap.set("n", "<C-e>", function()
		snacks.explorer()
	end, { desc = "Open Explorer" })

	vim.keymap.set("n", ";f", function()
		snacks.picker.files({ hidden = true })
	end, { desc = "Fuzzy find files in cwd" })

	vim.keymap.set("n", ";g", function()
		snacks.picker.grep({ hidden = true })
	end, { desc = "Find string in cwd" })

	vim.keymap.set("n", ";m", function()
		snacks.picker.marks()
	end, { desc = "Find marks in files" })

	vim.keymap.set("n", ";T", function()
		snacks.picker.grep({ search = "TODO|HACK|NOTE|FIX", hidden = true })
	end, { desc = "Find all TODOs,HACKs,NOTEs and FIXs" })

	vim.keymap.set("n", ";h", function()
		snacks.picker.help()
	end, { desc = "Find tags in files" })

	vim.keymap.set("n", ";d", function()
		snacks.picker.diagnostics()
	end, { desc = "Find all diagnostics" })

	vim.keymap.set("n", ";D", function()
		snacks.picker.diagnostics_buffer()
	end, { desc = "Find all diagnostics in workspace" })

	vim.keymap.set("n", ";b", function()
		snacks.picker.buffers()
	end, { desc = "Find all buffers" })

	vim.keymap.set("n", ";k", function()
		snacks.picker.keymaps()
	end, { desc = "Find vim.keymaps" })

	vim.keymap.set("n", "<leader>si", function()
		snacks.picker.icons()
	end, { desc = "Find Icons emoji" })

	vim.keymap.set("n", ";z", function()
		snacks.picker.spelling()
	end, { desc = "show spell words suggestions" })

	vim.keymap.set("n", "<leader>uC", function()
		snacks.picker.colorschemes()
	end, { desc = "chose coloscheme" })

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesActionRename",
		callback = function(event)
			Snacks.rename.on_rename_file(event.data.from, event.data.to)
		end,
	})
end)

later(function()
	add({
		source = "nvim-treesitter/nvim-treesitter",
		-- Use 'master' while monitoring updates in 'main'
		checkout = "master",
		monitor = "main",
		-- Perform action after every checkout
		hooks = {
			post_checkout = function()
				vim.cmd("TSUpdate")
			end,
		},
	})
	-- Possible to immediately execute code which depends on the added plugin
	require("nvim-treesitter.configs").setup({
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

later(function()
	add({
		source = "saghen/blink.cmp",
		depends = { "rafamadriz/friendly-snippets", "echasnovski/mini.icons" },
		checkout = "1.*", -- check releases for latest tag
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
						{ "kind_icon", "kind", gap = 1 },
						{ "label", "label_description", gap = 1 },
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

later(function()
	add({ source = "echasnovski/mini.comment" })
	require("mini.comment").setup({})
end)

now(function()
	add({ source = "echasnovski/mini.icons" })
	require("mini.icons").setup({})
end)

later(function()
	add({ source = "echasnovski/mini.move" })
	require("mini.move").setup({})
end)

later(function()
	add({ source = "echasnovski/mini.pairs" })
	require("mini.pairs").setup({})
end)

later(function()
	add({ source = "echasnovski/mini.diff" })
	require("mini.diff").setup({ view = { style = "sign" } })
end)

later(function()
	add({ source = "echasnovski/mini.keymap" })
	local map_combo = require("mini.keymap").map_combo
	local mode = { "i", "c", "x", "s" }
	map_combo(mode, "jk", "<BS><BS><Esc>")
	-- Escape into Normal mode from Terminal mode
	map_combo("t", "jk", "<BS><BS><C-\\><C-n>")
end)

now(function()
	add({ source = "echasnovski/mini.statusline", depends = { "echasnovski/mini.icons" } })
	local line = require("mini.statusline")
	line.setup({
		content = {
			active = function()
				local mode, mode_hl = line.section_mode({ trunc_width = 120 })
				local git = line.section_git({ trunc_width = 40 })
				local diff = line.section_diff({ trunc_width = 75 })
				local diagnostics = line.section_diagnostics({ trunc_width = 75 })
				local lsp = line.section_lsp({ trunc_width = 75 })
				local filename = line.section_filename({ trunc_width = 140 })
				local fileinfo = line.section_fileinfo({ trunc_width = 120 })
				local search = line.section_searchcount({ trunc_width = 75 })

				return line.combine_groups({
					{ hl = mode_hl, strings = { mode } },
					{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
					"%<", -- Mark general truncate point
					{ hl = "MiniStatuslineFilename", strings = { filename } },
					"%=", -- End left alignment
					{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
					{ hl = mode_hl, strings = { search, "%P %l:%c" } },
				})
			end,
		},
	})
end)

later(function()
	add({ source = "echasnovski/mini.bracketed" })

	require("mini.bracketed").setup({
		buffer = { suffix = "b", options = {} }, -- using cybu
		comment = { suffix = "c", options = {} },
		conflict = { suffix = "x", options = {} },
		-- don't want diagnostic float focus, have in mappings.lua with coc
		-- support too
		diagnostic = { suffix = "d", options = {} },
		file = { suffix = "", options = {} },
		indent = { suffix = "", options = {} }, -- confusing
		jump = { suffix = "", options = {} }, -- redundant
		location = { suffix = "", options = {} },
		oldfile = { suffix = "", options = {} },
		quickfix = { suffix = "q", options = {} },
		treesitter = { suffix = "t", options = {} },
		undo = { suffix = "", options = {} },
		window = { suffix = "", options = {} }, -- broken going to unlisted
		yank = { suffix = "", options = {} }, -- confusing
	})
end)

later(function()
	add({ source = "echasnovski/mini.surround" })
	require("mini.surround").setup({
		mappings = {
			add = "<leader>sa", -- Add surrounding in Normal and Visual modes
			delete = "<leader>sd", -- Delete surrounding
			find = "", -- Find surrounding (to the right)
			find_left = "", -- Find surrounding (to the left)
			highlight = "", -- Highlight surrounding
			replace = "<leader>sr", -- Replace surrounding
			update_n_lines = "", -- Update `n_lines`

			suffix_last = "", -- Suffix to search with "prev" method
			suffix_next = "", -- Suffix to search with "next" method
		},
	})
end)

later(function()
	add({ source = "echasnovski/mini.cursorword" })
	require("mini.cursorword").setup({})
end)

later(function()
	add({ source = "echasnovski/mini.files", depends = { "echasnovski/mini.icons" } })
	local MiniFiles = require("mini.files")

	MiniFiles.setup({
		mappings = {
			close = "q",
			go_in = "l",
			go_in_plus = "L",
			go_out = "h",
			go_out_plus = "H",
			mark_goto = "'",
			mark_set = "m",
			reset = ",",
			reveal_cwd = "?",
			show_help = "g?",
			synchronize = "=",
			trim_left = "<",
			trim_right = ">",
		},
	})

	local minifiles_toggle = function(...)
		if not MiniFiles.close() then
			MiniFiles.open(...)
		end
	end

	vim.keymap.set("n", "<leader>e", function()
		local path = vim.bo.buftype ~= "nofile" and vim.api.nvim_buf_get_name(0) or nil
		minifiles_toggle(path)
	end, { desc = "Open mini.files (cwd)" })

	-- All config below is to render git status in mini.files
	-- See gist for more details: https://gist.github.com/bassamsdata/eec0a3065152226581f8d4244cce9051
	local nsMiniFiles = vim.api.nvim_create_namespace("mini_files_git")
	local autocmd = vim.api.nvim_create_autocmd

	-- Cache for git status
	local gitStatusCache = {}
	local cacheTimeout = 2000 -- in milliseconds
	local uv = vim.uv or vim.loop

	local function isSymlink(path)
		local stat = uv.fs_lstat(path)
		return stat and stat.type == "link"
	end

	---@type table<string, {symbol: string, hlGroup: string}>
	---@param status string
	---@return string symbol, string hlGroup
	local function mapSymbols(status, is_symlink)
		local statusMap = {
			[" M"] = { symbol = "✹", hlGroup = "MiniDiffSignChange" }, -- Modified in the working directory
			["M "] = { symbol = "•", hlGroup = "MiniDiffSignChange" }, -- modified in index
			["MM"] = { symbol = "≠", hlGroup = "MiniDiffSignChange" }, -- modified in both working tree and index
			["A "] = { symbol = "+", hlGroup = "MiniDiffSignAdd" }, -- Added to the staging area, new file
			["AA"] = { symbol = "≈", hlGroup = "MiniDiffSignAdd" }, -- file is added in both working tree and index
			["D "] = { symbol = "-", hlGroup = "MiniDiffSignDelete" }, -- Deleted from the staging area
			["AM"] = { symbol = "⊕", hlGroup = "MiniDiffSignChange" }, -- added in working tree, modified in index
			["AD"] = { symbol = "-•", hlGroup = "MiniDiffSignChange" }, -- Added in the index and deleted in the working directory
			["R "] = { symbol = "→", hlGroup = "MiniDiffSignChange" }, -- Renamed in the index
			["U "] = { symbol = "‖", hlGroup = "MiniDiffSignChange" }, -- Unmerged path
			["UU"] = { symbol = "⇄", hlGroup = "MiniDiffSignAdd" }, -- file is unmerged
			["UA"] = { symbol = "⊕", hlGroup = "MiniDiffSignAdd" }, -- file is unmerged and added in working tree
			["??"] = { symbol = "?", hlGroup = "MiniDiffSignDelete" }, -- Untracked files
			["!!"] = { symbol = "!", hlGroup = "MiniDiffSignChange" }, -- Ignored files
		}

		local result = statusMap[status] or { symbol = "?", hlGroup = "NonText" }
		local gitSymbol = result.symbol
		local gitHlGroup = result.hlGroup

		local symlinkSymbol = is_symlink and "↩" or ""

		-- Combine symlink symbol with Git status if both exist
		local combinedSymbol = (symlinkSymbol .. gitSymbol):gsub("^%s+", ""):gsub("%s+$", "")
		-- Change the color of the symlink icon from "MiniDiffSignDelete" to something else
		local combinedHlGroup = is_symlink and "MiniDiffSignDelete" or gitHlGroup

		return combinedSymbol, combinedHlGroup
	end

	---@param cwd string
	---@param callback function
	---@return nil
	local function fetchGitStatus(cwd, callback)
		local clean_cwd = cwd:gsub("^minifiles://%d+/", "")
		---@param content table
		local function on_exit(content)
			if content.code == 0 then
				callback(content.stdout)
				-- vim.g.content = content.stdout
			end
		end
		---@see vim.system
		vim.system({ "git", "status", "--ignored", "--porcelain" }, { text = true, cwd = clean_cwd }, on_exit)
	end

	---@param buf_id integer
	---@param gitStatusMap table
	---@return nil
	local function updateMiniWithGit(buf_id, gitStatusMap)
		vim.schedule(function()
			local nlines = vim.api.nvim_buf_line_count(buf_id)
			local cwd = vim.fs.root(buf_id, ".git")
			local escapedcwd = cwd and vim.pesc(cwd)
			if not escapedcwd then
				return
			end
			escapedcwd = vim.fs.normalize(escapedcwd)

			for i = 1, nlines do
				local entry = MiniFiles.get_fs_entry(buf_id, i)
				if not entry then
					break
				end
				local relativePath = entry.path:gsub("^" .. escapedcwd .. "/", "")
				local status = gitStatusMap[relativePath]

				if status then
					local symbol, hlGroup = mapSymbols(status, isSymlink(entry.path))
					vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, 0, {
						sign_text = symbol,
						sign_hl_group = hlGroup,
						priority = 2,
					})
					-- This below code is responsible for coloring the text of the items. comment it out if you don't want that
					local line = vim.api.nvim_buf_get_lines(buf_id, i - 1, i, false)[1]
					-- Find the name position accounting for potential icons
					local nameStartCol = line:find(vim.pesc(entry.name)) or 0

					if nameStartCol > 0 then
						vim.api.nvim_buf_set_extmark(buf_id, nsMiniFiles, i - 1, nameStartCol - 1, {
							end_col = nameStartCol + #entry.name - 1,
							hl_group = hlGroup,
						})
					end
				else
				end
			end
		end)
	end

	-- Thanks for the idea of gettings https://github.com/refractalize/oil-git-status.nvim signs for dirs
	---@param content string
	---@return table
	local function parseGitStatus(content)
		local gitStatusMap = {}
		-- lua match is faster than vim.split (in my experience )
		for line in content:gmatch("[^\r\n]+") do
			local status, filePath = string.match(line, "^(..)%s+(.*)")
			-- Split the file path into parts
			local parts = {}
			for part in filePath:gmatch("[^/]+") do
				table.insert(parts, part)
			end
			-- Start with the root directory
			local currentKey = ""
			for i, part in ipairs(parts) do
				if i > 1 then
					-- Concatenate parts with a separator to create a unique key
					currentKey = currentKey .. "/" .. part
				else
					currentKey = part
				end
				-- If it's the last part, it's a file, so add it with its status
				if i == #parts then
					gitStatusMap[currentKey] = status
				else
					-- If it's not the last part, it's a directory. Check if it exists, if not, add it.
					if not gitStatusMap[currentKey] then
						gitStatusMap[currentKey] = status
					end
				end
			end
		end
		return gitStatusMap
	end

	---@param buf_id integer
	---@return nil
	local function updateGitStatus(buf_id)
		if not vim.fs.root(buf_id, ".git") then
			return
		end
		local cwd = vim.fs.root(buf_id, ".git")
		-- local cwd = vim.fn.expand("%:p:h")
		if not cwd then
			return
		end
		local currentTime = os.time()

		if gitStatusCache[cwd] and currentTime - gitStatusCache[cwd].time < cacheTimeout then
			updateMiniWithGit(buf_id, gitStatusCache[cwd].statusMap)
		else
			fetchGitStatus(cwd, function(content)
				local gitStatusMap = parseGitStatus(content)
				gitStatusCache[cwd] = {
					time = currentTime,
					statusMap = gitStatusMap,
				}
				updateMiniWithGit(buf_id, gitStatusMap)
			end)
		end
	end

	---@return nil
	local function clearCache()
		gitStatusCache = {}
	end

	local function augroup(name)
		return vim.api.nvim_create_augroup("MiniFiles_" .. name, { clear = true })
	end

	autocmd("User", {
		group = augroup("start"),
		pattern = "MiniFilesExplorerOpen",
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			updateGitStatus(bufnr)
		end,
	})

	autocmd("User", {
		group = augroup("close"),
		pattern = "MiniFilesExplorerClose",
		callback = function()
			clearCache()
		end,
	})

	autocmd("User", {
		group = augroup("update"),
		pattern = "MiniFilesBufferUpdate",
		callback = function(args)
			local bufnr = args.data.buf_id
			local cwd = vim.fs.root(bufnr, ".git")
			if gitStatusCache[cwd] then
				updateMiniWithGit(bufnr, gitStatusCache[cwd].statusMap)
			end
		end,
	})
end)

later(function()
	add({
		source = "williamboman/mason.nvim",
		depends = { "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" },
	})

	opts = {
		servers = {
			ts_ls = {},
			html = { filetypes = { "html", "twig", "hbs" } },
			cssls = {},
			tailwindcss = {},
			jsonls = {},
			svelte = {},

			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						diagnostics = { disable = { "missing-fields" } },
						format = {
							enable = false,
						},
					},
				},
			},
		},
	}

	require("mason").setup()

	require("mason-lspconfig").setup({
		automatic_enable = false,
		ensure_installed = { "lua_ls", "ts_ls", "tailwindcss", "svelte" },
	})

	vim.diagnostic.config({
		underline = true,
		virtual_text = true,
	})

	for server, config in pairs(opts.servers) do
		vim.lsp.config(server, require("blink.cmp").get_lsp_capabilities(config.capabilities))
		vim.lsp.enable(server)
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("UserLspConfig", {}),
		callback = function(ev)
			vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc" -- enable completion trigerred

			-- Buffer local mappings.
			-- See ":help vim.lsp.*" for documentation
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
			end

			local picker = require("snacks.picker")

			map("gd", function()
				picker.lsp_definitions()
			end, "[G]oto [D]efinition")
			map("gr", function()
				picker.lsp_references()
			end, "[G]oto [R]eferences")
			map("gi", function()
				picker.lsp_implementations()
			end, "[G]oto [I]mplementation")
			map("ds", function()
				picker.lsp_workspace_symbols()
			end, "[D]ocument [S]ymbols")
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
			map("K", vim.lsp.buf.hover, "show information in hover")
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
		end,
	})
end)

later(function()
	add({ source = "stevearc/conform.nvim" })
	local conform = require("conform")
	conform.setup({
		formatters_by_ft = {
			javascript = prettier,
			typescript = prettier,
			javascriptreact = prettier,
			typescriptreact = prettier,
			svelte = prettier,
			css = prettier,
			html = prettier,
			json = prettier,
			jsonc = prettier,
			yaml = prettier,
			markdown = prettier,
			graphql = prettier,
			sql = { "sql-formatter" },
			lua = { "stylua" },
			c = { "clang-format" },
			-- rust = { "ast_grep" },
			python = { "isort", "black" },
			bash = { "shfmt" },
			shell = { "shfmt" },
		},
		format_on_save = {
			lsp_fallback = true,
			async = false,
			timeout_ms = 1001,
		},
		formatters = {
			astyle = {
				command = "astyle",
				prepend_args = { "-s3", "-c", "-J", "-n", "-q", "-z2", "-xC80" },
			},
			-- ["clang-format"] = {
			-- 	command = "clang-format",
			-- 	prepend_args = { "--style=file", "-i" },
			-- },
			["cmake-format"] = {
				command = "cmake-format",
				prepend_args = { "-i" },
			},
			prettier = {
				command = "prettier",
				prepend_args = { "-w" },
			},
			prettierd = {
				command = "prettierd",
				prepend_args = { "-w" },
			},
			["sql-formatter"] = {
				command = "sql-formatter",
				prepend_args = {
					"--language=postgresql",
				},
			},
		},
	})

	vim.keymap.set({ "n", "v" }, "<leader>cf", function()
		conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
	end, { desc = "Format file or range (in visual mode)" })
end)

later(function()
	add({ source = "mfussenegger/nvim-lint" })

	local lint = require("lint")

	local eslint = { "eslint_d" }

	lint.linters_by_ft = {
		javascript = eslint,
		typescript = eslint,
		javascriptreact = eslint,
		typescriptreact = eslint,
		svelte = eslint,
		python = { "pylint" },
		-- rust = { "ast_grep" },
		-- c = { "ast_grep" },
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			lint.try_lint()
		end,
	})

	vim.keymap.set("n", "<leader>lt", function()
		lint.try_lint()
	end, { desc = "Trigger linting for current file" })
end)
