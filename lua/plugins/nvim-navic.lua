return {
	"SmiteshP/nvim-navic",
	dependencies = { "neovim/nvim-lspconfig" },
  opts = function()
    return {
      separator = " ",
      highlight = true,
      depth_limit = 5,
      lazy_update_context = true,
    }
  end,
}
