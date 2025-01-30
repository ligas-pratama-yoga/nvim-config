return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
    enabled = false,
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find file <cwd>" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffer" })
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
			vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Find recent files" })
			vim.keymap.set("n", "<leader>fc", function()
				require("telescope.builtin").find_files({ cwd = "~/.config/nvim" })
			end, { desc = "Find config files" })
			vim.keymap.set("n", "<leader>fF", function()
				require("telescope.builtin").find_files({ cwd = "~" })
			end, { desc = "Find files <root>" })
			vim.keymap.set("n", "<leader>fr", ":Telescope file_browser<CR>", { desc = "Telescope Browse" })
			-- This is your opts table
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
				file_browser = {
					theme = "ivy",
					hijack_netrw = true,
				},
			})
			require("telescope").load_extension("ui-select")
			require("telescope").load_extension("file_browser")
		end,
	},
	-- { "nvim-telescope/telescope-ui-select.nvim" },
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- },
}
