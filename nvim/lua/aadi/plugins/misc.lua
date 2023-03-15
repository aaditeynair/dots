return {
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({
                window = {
                    backdrop = 0.50,
                },
                plugins = {
                    gitsigns = true,
                    tmux = false,
                    kitty = { enabled = false, font = "+2" },
                    twilight = false,
                },
            })
        end,
    },

    { "folke/twilight.nvim", cmd = "Twilight" },

    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
}
