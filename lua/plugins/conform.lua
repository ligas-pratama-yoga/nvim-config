return {
	"stevearc/conform.nvim",
	dependencies = { "mason.nvim" },
	lazy = true,
	cmd = "ConformInfo",
	keys = {
		-- {
		-- 	"<leader>cF",
		-- 	function()
		-- 		require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
		-- 	end,
		-- 	mode = { "n", "v" },
		-- 	desc = "Format Injected Langs",
		-- },
		{
			"<leader>gf",
			function()
				require("conform").format()
			end,
			mode = { "n", "v" },
			desc = "Format file",
			noremap = true,
		},
	},
	-- init = function()
	--   -- Install the conform formatter on VeryLazy
	--   LazyVim.on_very_lazy(function()
	--     LazyVim.format.register({
	--       name = "conform.nvim",
	--       priority = 100,
	--       primary = true,
	--       format = function(buf)
	--         require("conform").format({ bufnr = buf })
	--       end,
	--       sources = function(buf)
	--         local ret = require("conform").list_formatters(buf)
	--         ---@param v conform.FormatterInfo
	--         return vim.tbl_map(function(v)
	--           return v.name
	--         end, ret)
	--       end,
	--     })
	--   end)
	-- end,
	opts = function()
		local opts = {
			-- default_format_opts = {
			-- 	timeout_ms = 3000,
			-- 	lsp_format = "fallback", -- not recommended to change
			-- },
			formatters_by_ft = {
				lua = { "stylua" },
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				sql_ft = { "sqlfluff" },
				blade = { "blade-formatter" },
				java = { "clang-format" },
				php = { "php_cs_fixer" },
				go = { "goimports" },
			},
			format_on_save = {
				-- These options will be passed to conform.format()
				timeout_ms = 20000,
				async = false,
				lsp_format = "fallback",
			},
			-- The options you set here will be merged with the builtin formatters.
			-- You can also define any custom formatters here.
			formatters = {
				injected = { options = { ignore_errors = true } },
				-- # Example of using dprint only when a dprint.json file is present
				-- dprint = {
				--   condition = function(ctx)
				--     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
				--   end,
				-- },
				--
				-- # Example of using shfmt with extra args
				-- shfmt = {
				--   prepend_args = { "-i", "2", "-ci" },
				-- },
			},
		}
		return opts
	end,
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}
