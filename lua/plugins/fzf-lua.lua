return {
	"junegunn/fzf.vim",
  enabled = false,
  dependencies = {
		"junegunn/fzf",
	},
  keys = {
		{
			"<leader><space>",
			"<cmd>Files<cr>",
			desc = "Open current dir",
		},
		{
			"<leader>ff",
			"<cmd>Files<cr>",
			desc = "Open current dir",
		},
		{
			"<leader>fc",
			"<cmd>Files ~/.config/nvim/<cr>",
			desc = "Open configuration directory",
		},
	},
}


