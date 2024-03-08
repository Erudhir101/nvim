return {
	"norcalli/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local status, colorizer = pcall(require, "colorizer")
		if not status then
			return
		end

		colorizer.setup({
			css = { css_fn = true },
			html = { css_fn = true },
			js = { css_fn = true },
			jsx = { css_fn = true },
			tsx = { css_fn = true },
		})
	end,
}
