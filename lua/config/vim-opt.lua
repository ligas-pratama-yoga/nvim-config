vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set softtabstop=2")
vim.cmd("colorscheme tokyonight")
-- vim.cmd("set autochdir")
vim.cmd("set number")
vim.cmd("set relativenumber")
vim.cmd("set numberwidth=4")
vim.cmd("set confirm")
-- vim.cmd("set shellcmdflag=-command")
vim.cmd('set shellquote="')
vim.cmd("set shellxquote=")
vim.wo.signcolumn = "yes"
vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

local map = vim.keymap.set

-- New File
map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- Quit!
map("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit!", silent = true })

-- Save file
map("n", "ss", "<cmd>w<cr>", { desc = "Save File", silent = true })

-- Quit insert mode
map("i", "jj", "<esc>", { desc = "Quit Insert Mode", silent = true, noremap = true })

-- Buffer
map("n", "H", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "L", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Next delete" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- UI
map("n", "<leader>ui", "<cmd>IBLToggle<cr>", { desc = "Toggle Indent Line" })
map("n", "<leader>uh", "<cmd>TSToggle highlight<cr>", { desc = "Toggle Treesitter Highlight" })
map("n", "<leader>uc", function()
	require("nvim-highlight-colors").toggle()
end, { desc = "Toggle highlight color" })

-- Terminal
map("t", "jj", [[<C-\><C-n>]], {})

-- Change between window
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

map("n", "<leader>v", "<C-v>", { desc = "Visual block" })
