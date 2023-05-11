return {
    {
        "goolord/alpha-nvim",
        lazy = false,
        config = function()
            local function button(txt, keys)
                local opts = {
                    position = "left",
                    shortcut = "",
                    cursor = 5,
                    width = 50,
                    align_shortcut = "right",
                    hl_shortcut = "Keyword",
                }

                local function on_press()
                    local key = vim.api.nvim_replace_termcodes(keys .. "<Ignore>", true, false, true)
                    vim.api.nvim_feedkeys(key, "t", false)
                end

                return {
                    type = "button",
                    val = txt,
                    on_press = on_press,
                    opts = opts,
                }
            end

            local v_info = vim.version()
            local nvim_version = "NVIM v" .. v_info.major .. "." .. v_info.minor .. "." .. v_info.patch

            local header = {
                type = "text",
                val = {
                    "███    ██ ███████  ██████  ██    ██ ██ ███    ███ ",
                    "████   ██ ██      ██    ██ ██    ██ ██ ████  ████ ",
                    "██ ██  ██ █████   ██    ██ ██    ██ ██ ██ ████ ██ ",
                    "██  ██ ██ ██      ██    ██  ██  ██  ██ ██  ██  ██ ",
                    "██   ████ ███████  ██████    ████   ██ ██      ██ ",
                    "",
                    nvim_version,
                },
                opts = {
                    position = "left",
                    hl = "String",
                },
            }

            local footer = {
                type = "text",
                val = "assert brain.is_working == True",
                opts = {
                    hl = "String",
                },
            }

            local projects = {
                type = "group",
                val = {},
            }

            for i, project in ipairs(require("conduct").get_last_opened_projects()) do
                if i > 7 then
                    break
                end
                table.insert(
                    projects.val,
                    button("[" .. i .. "] " .. project, ":silent ConductLoadProject " .. project .. "<CR>")
                )
            end

            local commands = {
                type = "group",
                val = {
                    button("[1] Update Plugins", ":Lazy sync<CR>"),
                    button("[2] Open Terminal", ":TermOpen<CR>"),
                    button("[3] Open Config", ":ConductLoadProject nvim-config<CR>"),
                },
            }

            local help = {
                type = "group",
                val = {
                    button("[1] :help nvim", ":help nvim<CR>"),
                    button("[2] :checkhealth", ":checkhealth<CR>"),
                    button("[3] :help news", ":help news<CR>"),
                },
            }

            local section = {
                header = header,
                projects = projects,
                commands = commands,
                help = help,
                footer = footer,
            }

            local config = {
                layout = {
                    { type = "padding", val = 2 },
                    section.header,
                    { type = "padding", val = 2 },

                    { type = "text", val = "RECENT PROJECTS", opts = { hl = "String" } },
                    { type = "padding", val = 1 },
                    section.projects,
                    { type = "padding", val = 2 },

                    { type = "text", val = "COMMANDS", opts = { hl = "String" } },
                    { type = "padding", val = 1 },
                    section.commands,
                    { type = "padding", val = 2 },

                    { type = "text", val = "HELP", opts = { hl = "String" } },
                    { type = "padding", val = 1 },
                    section.help,
                    { type = "padding", val = 2 },

                    section.footer,
                },
                opts = {
                    margin = 5,
                },
            }

            require("alpha").setup({
                button = button,
                layout = config.layout,
                opts = config.opts,
            })
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            char = "▏",
        },
    },

    {
        "m4xshen/smartcolumn.nvim",
        opts = {
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

    {
        "declancm/maximize.nvim",
        opts = { default_keymaps = false },
    },
}
