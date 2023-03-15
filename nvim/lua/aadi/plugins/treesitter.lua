return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        config = function()
            require("nvim-treesitter.configs").setup({
                highlight = {
                    enable = true,
                    disable = {},
                    additional_vim_regex_highlighting = false,
                },
                ident = { enable = true, disable = { "yaml" } },
                autotag = { enable = true },
                ensure_installed = {
                    "astro",
                    "bash",
                    "cpp",
                    "css",
                    "gitignore",
                    "go",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "python",
                    "typescript",
                },
                auto_install = true,
            })
        end,
    },
}
