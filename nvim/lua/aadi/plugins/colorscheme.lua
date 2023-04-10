return {
    {
        "eddyekofo94/gruvbox-flat.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.g.gruvbox_transparent = true
            vim.api.nvim_command("colorscheme gruvbox-flat")

            local links = {
                ["@lsp.type.namespace"] = "@namespace",
                ["@lsp.type.type"] = "@type",
                ["@lsp.type.class"] = "@type",
                ["@lsp.type.enum"] = "@type",
                ["@lsp.type.interface"] = "@type",
                ["@lsp.type.struct"] = "@structure",
                ["@lsp.type.parameter"] = "@parameter",
                ["@lsp.type.variable"] = "@variable",
                ["@lsp.type.property"] = "@variable",
                ["@lsp.type.enumMember"] = "@constant",
                ["@lsp.type.function"] = "@function",
                ["@lsp.type.method"] = "@method",
                ["@lsp.type.macro"] = "@macro",
                ["@lsp.type.decorator"] = "@function",
            }
            for newgroup, oldgroup in pairs(links) do
                vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
            end

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

            vim.api.nvim_set_hl(0, "StatusLine", { bg = nil, fg = "#5a524c", underline = true, bold = true })
            vim.api.nvim_set_hl(0, "StatusLineNC", { bg = nil, fg = "#5a524c", underline = true })
            vim.cmd("let &statusline=' '")
        end,
    },
}
