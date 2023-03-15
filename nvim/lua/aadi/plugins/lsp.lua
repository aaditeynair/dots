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
                require("null-ls")

                local opts = { noremap = true, silent = true, buffer = bufnr }
                -- set keybinds
                keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
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

            lspconfig["html"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- configure css server
            lspconfig["cssls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- configure tailwindcss server
            lspconfig["tailwindcss"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            -- configure lua server (with special settings)
            lspconfig["lua_ls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
                settings = { -- custom settings for lua
                    Lua = {
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

            lspconfig["astro"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig["tsserver"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig["pyright"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig["eslint"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })

            lspconfig["bashls"].setup({
                capabilities = capabilities,
                on_attach = on_attach,
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
            -- keybinds for navigation in lspsaga window
            move_in_saga = { prev = "<C-k>", next = "<C-j>" },
        },
    },

    {
        "williamboman/mason.nvim",
        dependencies = "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason").setup()
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "html",
                    "cssls",
                    "tailwindcss",
                    "lua_ls",
                    "astro",
                    "tsserver",
                    "pyright",
                    "bashls",
                    "eslint",
                },
            })
        end,
    },

    {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
            local nls = require("null-ls")

            nls.setup({
                sources = {
                    nls.builtins.formatting.black,
                    nls.builtins.formatting.prettier,
                    nls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
                },
                on_attach = function(current_client, bufnr)
                    if current_client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    filter = function(client)
                                        --  only use null-ls for formatting instead of lsp server
                                        return client.name == "null-ls"
                                    end,
                                    bufnr = bufnr,
                                })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
