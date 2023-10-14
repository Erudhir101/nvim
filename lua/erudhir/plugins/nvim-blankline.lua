return {
	{
		"lukas-reineke/indent-blankline.nvim",
		-- event = "VeryLazy",
		event = { "CursorHold", "CursorHoldI" },
		main = "ibl",
		config = function()
			local status, blank = pcall(require, "ibl")
			if not status then
				return
			end
			blank.setup()
		end,
	},
}
