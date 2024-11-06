return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	opts = {
		-- left = {
		-- 	{
		-- 		title = "Database",
		-- 		ft = "dbui",
		-- 		pinned = true,
		-- 		width = 0.3,
		-- 		open = function()
		-- 			vim.cmd("DBUI")
		-- 		end,
		-- 	},
		-- },
		bottom = {
			-- toggleterm / lazyterm at the bottom with a height of 40% of the screen
			{
				ft = "toggleterm",
				size = { height = 0.4 },
				-- exclude floating windows
				filter = function(buf, win)
					return vim.api.nvim_win_get_config(win).relative == ""
				end,
			},
			{
				title = "DB Query Result",
				ft = "dbout",
			},
			{
				title = "Diagnostics",
				ft = "qf",
			},
		},
	},
}
