local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add({
		source = "neovim/nvim-lspconfig",
		depends = {
			"williamboman/mason-lspconfig.nvim",
			"williamboman/mason.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
	})

	local opts = {
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
	require("mason-lspconfig").setup()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"eslint_d",
			"lua_ls",
			"prettierd",
			"stylua",
			"svelte",
			"tailwindcss",
			"ts_ls",
		},
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

			local buf = vim.lsp.buf

			map("gd", buf.definition, "[G]oto [D]efinition")
			map("gr", buf.references, "[G]oto [R]eferences")
			map("gi", buf.implementation, "[G]oto [I]mplementation")
			map("ds", buf.workspace_symbol, "[D]ocument [S]ymbols")
			map("<leader>rn", buf.rename, "[R]e[n]ame")
			map("K", buf.hover, "show information in hover")
			map("<leader>ca", buf.code_action, "[C]ode [A]ction", { "n", "x" })
		end,
	})
end)

now(function()
	add({ source = "mfussenegger/nvim-lint" })

	local lint = require("lint")

	local eslint = { "eslint_d" }

	lint.linters_by_ft = {
		javascript = eslint,
		typescript = eslint,
		javascriptreact = eslint,
		typescriptreact = eslint,
		svelte = eslint,
		-- python = { "pylint" },
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
