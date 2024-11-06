return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    autochdir = true,
    auto_scroll = true,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)
    vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<cr>", { desc = "ToggleTerm" })
  end,
}
