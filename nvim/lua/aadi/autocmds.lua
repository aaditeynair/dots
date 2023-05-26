vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    desc = "enter insert mode",
    pattern = "term://*",
    callback = function()
        vim.cmd("startinsert")
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "change stuff for colorschemes",
    callback = function()
        local links = {
            ["@lsp.type.namespace"] = "@namespace",
            ["@lsp.type.type"] = "@type",
            ["@lsp.type.class"] = "@type",
            ["@lsp.type.enum"] = "@type",
            ["@lsp.type.interface"] = "@type",
            ["@lsp.type.struct"] = "@structure",
            ["@lsp.type.parameter"] = "@parameter",
            ["@lsp.type.variable"] = "@variable",
            ["@lsp.type.property"] = "@property",
            ["@lsp.type.enumMember"] = "@constant",
            ["@lsp.type.function"] = "@function",
            ["@lsp.type.method"] = "@method",
            ["@lsp.type.macro"] = "@macro",
            ["@lsp.type.decorator"] = "@function",
        }
        for newgroup, oldgroup in pairs(links) do
            vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
        end
    end,
})
