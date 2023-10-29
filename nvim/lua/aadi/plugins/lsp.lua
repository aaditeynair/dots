return {
	{
		"neovim/nvim-lspconfig",
		name = "lsp",
		event = "BufReadPre",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "folke/neodev.nvim" },
		config = function()
			require("mason")
			require("lspsaga")

			local lspconfig_status, lspconfig = pcall(require, "lspconfig")
			if not lspconfig_status then
				return
			end

			local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if not cmp_nvim_lsp_status then
				return
			end

			local keymap = vim.keymap

			local on_attach = function(_, bufnr)
				local opts = { noremap = true, silent = true, buffer = bufnr }
				-- set keybinds
				keymap.set("n", "gf", "<cmd>Lspsaga finder<CR>", opts) -- show definition, references
				keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts) -- got to declaration
				keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
				keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
				keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
				keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
				keymap.set("n", "<leader>d", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
				keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
				keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
				keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
				keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
				keymap.set("n", "<leader>go", "<cmd>SymbolsOutline<CR>", opts) -- see outline on right hand side
			end

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = cmp_nvim_lsp.default_capabilities()

			local get_servers = require("mason-lspconfig").get_installed_servers
			for _, server_name in ipairs(get_servers()) do
				lspconfig[server_name].setup({
					capabilities = capabilities,
					on_attach = on_attach,
				})
			end

			lspconfig["gopls"].setup({
				settings = {
					gopls = {
						gofumpt = true,
						completeUnimported = true,
						usePlaceholders = true,
					},
				},
			})

			-- configure lua server (with special settings)
			lspconfig["lua_ls"].setup({
				capabilities = capabilities,
				on_attach = on_attach,
				settings = { -- custom settings for lua
					Lua = {
						-- semantic = {
						--     enable = false,
						-- },
						-- make the language server recognize "vim" global
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							-- make language server aware of runtime files
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})
		end,
	},

	{
		"glepnir/lspsaga.nvim",
		opts = {
			symbol_in_winbar = {
				enable = false,
			},
			ui = {
				border = "single",
				colors = {
					normal_bg = "",
				},
			},
			definition = {
				edit = "<CR>",
			},
			diagnostic = {
				on_insert = false,
			},
			rename = {
				keys = { quit = "<C-q>" },
			},
		},
	},

	{
		"williamboman/mason.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer" },
		config = function()
			require("mason").setup()

			require("mason-lspconfig").setup({
				automatic_installation = true,
			})

			require("mason-tool-installer").setup({
				ensure_installed = {
					-- LSP Servers
					"astro",
					"bashls",
					"cssls",
					"gopls",
					"html",
					"lua_ls",
					"marksman",
					"pyright",
					"tailwindcss",
					"tsserver",
					"vimls",

					-- Formatters
					"prettier",
					"shfmt",
					"stylua",
					"isort",
					"black",
					"codespell",
					"gofumpt",
					"goimports-reviser",

					-- Linters
					"markdownlint",
					"eslint_d",
					"pylint",
					"revive",
				},
			})
		end,
	},
}
