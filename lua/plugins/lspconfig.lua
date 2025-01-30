return {
	{
		"L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			require("luasnip.loaders.from_vscode").lazy_load()
			-- https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/cmp.lua#L13
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end
			cmp.setup({
				completion = {
					completeopt = "menu, menuone, preview",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					-- completion = cmp.config.window.bordered(),
					-- documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					-- Thanks so much for https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/cmp.lua#L68
					-- You save my life
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, {
						"i",
						"s",
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" }, -- For luasnip users.
					{ name = "buffer" },
					{ name = "path" },
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})
		end,
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lsp = require("mason-lspconfig")
			mason.setup({
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
			mason_lsp.setup({
				automatic_installation = true,
			})
			vim.keymap.set("n", "<leader>cm", "<cmd>Mason<cr>", { desc = "Mason" })
		end,
	},
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "antosha417/nvim-lsp-file-operations", config = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")
			local keymap_set = vim.keymap.set
			local navic = require("nvim-navic")
			local opts = { noremap = true, silent = true }
			local on_attach = function(client, bufnr)
				if client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end

				opts.buffer = bufnr

				opts.desc = "Telscope LSP Defintiton"
				keymap_set("n", "<leader>gd", "<cmd>Telescope lsp_definitions<cr>", opts)
				opts.desc = "Go to declaration"
				keymap_set("n", "<leader>gD", vim.lsp.buf.declaration, opts)
				opts.desc = "LSP hover"
				keymap_set("n", "K", vim.lsp.buf.hover, opts)
				opts.desc = "Code action"
				keymap_set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				opts.desc = "Smart rename"
				keymap_set("n", "<leader>cr", vim.lsp.buf.rename, opts)
			end
			local signs = {
				{ name = "DiagnosticSignError", text = "" },
				{ name = "DiagnosticSignWarn", text = "" },
				{ name = "DiagnosticSignHint", text = "" },
				{ name = "DiagnosticSignInfo", text = "" },
			}

			for _, sign in ipairs(signs) do
				vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
			end
			local capabilities = cmp_nvim_lsp.default_capabilities()
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}

			lspconfig["html"].setup({
				filetypes = { "html", "blade" },
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig["cssls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig["tailwindcss"].setup({
				filetypes = { "html" },
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig["emmet_language_server"].setup({
				filetypes = { "html", "css", "blade", "php" },
				capabilities = capabilities,
				on_attach = on_attach,
			})
			lspconfig["ts_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			-- lspconfig["phpactor"].setup({
			-- 	capabilities = capabilities,
			-- 	on_attach = on_attach,
			-- })

			lspconfig["intelephense"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["jdtls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})

			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},

						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})

			lspconfig["gopls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
			})
			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					-- delay update diagnostics
					update_in_insert = true,
				})
		end,
	},
}
