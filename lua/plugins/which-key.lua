return {
	"folke/which-key.nvim",
	event = "VeryLazy",
  opts_extend = { "spec" },
	opts = {
    spec = {
      mode = {
        'n', 'v'
      },
      { '<leader>f', group = "file/find" },
      { '<leader>g', group = "goto" },
      { '<leader>c', group = "code" },
      { '<leader>b', group = "buffer" },
      { 'gs', group = "surround" },
    }
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
