return {
    {
        "EdenEast/nightfox.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.api.nvim_command("colorscheme dawnfox")
        end,
    },
}
