return {
    {
        "EdenEast/nightfox.nvim",
    },
    {
        "shaunsingh/nord.nvim",
    },
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("kanagawa").setup({
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                            },
                        },
                    },
                },
            })

            vim.cmd("colorscheme kanagawa")
        end,
    },
}
