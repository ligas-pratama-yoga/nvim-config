return {
  "ngtuonghy/live-server-nvim",
  event = "VeryLazy",
  build = ":LiveServerInstall",
  config = function()
    require("live-server-nvim").setup({
      custom = {
        "--port=8088",
      },
      serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
      open = "folder",                                     -- folder|cwd     --default
    })
    vim.keymap.set("n", "<leader>cls", function()
      require("live-server-nvim").toggle()
    end, { desc = "Toggle Live Server" })
  end,
}
