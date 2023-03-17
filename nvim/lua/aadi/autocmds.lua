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

vim.api.nvim_create_user_command("SLoadCwd", function()
    local cwd = vim.fn.getcwd()
    local sessions = require("possession.session").list()
    for _, session in pairs(sessions) do
        if cwd == session.cwd then
            require("possession.session").load(session.name)
        end
    end
end, { nargs = 0 })
