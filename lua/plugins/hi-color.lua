return {
  "brenoprata10/nvim-highlight-colors",
  opts = {
    render = "virtual",
    virtual_symbol = "■",
    virtual_symbol_prefix = " ",
    virtual_symbol_suffix = " ",

    ---Set virtual symbol position()
    ---@usage 'inline'|'eol'|'eow'
    ---inline mimics VS Code style
    ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
    ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
    virtual_symbol_position = "eow",
  },
  config = function(_, opts)
    vim.opt.termguicolors = true
    require("nvim-highlight-colors").setup(opts)
    require("cmp").setup({
      formatting = {
        format = function(entry, item)
          return require("nvim-highlight-colors").format(entry, item)
        end,
      },
    })
  end,
}
