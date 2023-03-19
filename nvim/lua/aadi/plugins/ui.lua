return {
    {
        "goolord/alpha-nvim",
        lazy = false,
        config = function()
            local alpha_status, alpha = pcall(require, "alpha")
            if not alpha_status then
                return
            end

            local dashboard_status, dashboard = pcall(require, "alpha.themes.dashboard")
            if not dashboard_status then
                return
            end

            dashboard.section.header.val = {
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
                "████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
                "██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
                "██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
                "██   ████ ███████  ██████    ████   ██ ██      ██ ",
                "",
            }

            dashboard.section.buttons.val = {
                dashboard.button("SPC s l", " Load CWD Session", ":SLoadCwd<CR>"),
                dashboard.button("SPC s r", " Load Last Session", ":PossessionLoad<CR>"),
                dashboard.button("SPC s s", " List All Sessions", ":Telescope possession list<CR>"),
            }

            dashboard.section.header.opts.margin = 20

            alpha.setup(dashboard.opts)

            dashboard.section.footer.val = { "", "assert brain.is_working == True" }
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        config = {
            char = "▏",
        },
    },

    {
        "m4xshen/smartcolumn.nvim",
        opts = {
            colorcolumn = 80,
            disabled_filetypes = {
                "help",
                "text",
                "markdown",
                "lazy",
                "Trouble",
            },
        },
        event = "BufReadPost",
    },

    { "nvim-tree/nvim-web-devicons" },

    {
        "rcarriga/nvim-notify",
        event = "VeryLazy",
        config = function()
            require("notify").setup({
                background_colour = "#000000",
                stages = "fade",
            })
            vim.notify = require("notify")
        end,
    },
}
