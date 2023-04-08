vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Hightlight selection on yank",
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    desc = "Set local options for terminal buffers",
    pattern = "*",
    callback = function()
        vim.cmd("setlocal nonumber norelativenumber")
        vim.keymap.set("n", "<leader>q", "<CMD>Bdelete!<CR>", {
            silent = true,
            buffer = 0,
        })
    end,
})

vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "change stuff for colorschemes",
    callback = function()
        for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
            vim.api.nvim_set_hl(0, group, {})
        end
    end,
})
