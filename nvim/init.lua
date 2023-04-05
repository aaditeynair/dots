require("aadi.options")
require("aadi.lazy")

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require("aadi.keymaps")
        require("aadi.autocmds")
        require("aadi.utils")
    end,
})
