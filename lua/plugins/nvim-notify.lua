return {
  'rcarriga/nvim-notify',
  enabled = false,
  config = function ()
    local notify = require("notify")
    notify.setup({
      timeout = 5000
    })
    vim.notify = notify
  end
}


