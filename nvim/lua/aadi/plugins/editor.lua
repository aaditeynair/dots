return {
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        config = true,
    },

    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",

        config = function()
            local mark = require("harpoon.mark")
            local ui = require("harpoon.ui")

            vim.keymap.set("n", "<leader>a", function()
                mark.toggle_file()
                require("sidebar-nvim").update()
            end)

            vim.keymap.set("n", "<A-e>", function()
                ui.toggle_quick_menu()
            end)

            vim.keymap.set("n", "<A-h>", function()
                ui.nav_file(1)
            end)
            vim.keymap.set("n", "<A-t>", function()
                ui.nav_file(2)
            end)
            vim.keymap.set("n", "<A-m>", function()
                ui.nav_file(3)
            end)
            vim.keymap.set("n", "<A-l>", function()
                ui.nav_file(4)
            end)
        end,
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        cmd = "Neotree",
        config = function()
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            require("neo-tree").setup({
                close_if_last_window = true,
                enable_git_status = false,
                default_component_configs = {
                    indent = {
                        with_expanders = true,
                    },
                },
                window = {
                    width = 35,
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
                event_handlers = {
                    {
                        event = "neo_tree_window_before_open",
                        handler = function(_)
                            require("sidebar-nvim").close()
                        end,
                    },
                },
            })
            vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#d5c4a1" })
            vim.api.nvim_set_hl(0, "NeoTreeCursorLine", { bg = "none" })
        end,
    },

    {
        "jedrzejboczar/possession.nvim",
        cmd = { "PossessionLoad", "PossessionSave", "PossessionDelete" },
        opts = {
            silent = true,
            autosave = {
                current = true,
                on_quit = true,
            },
            plugins = {
                nvim_tree = false,
                tabby = false,
                delete_hidden_buffers = {
                    hooks = {},
                    force = false,
                },
            },
            hooks = {
                before_save = function(_)
                    require("sidebar-nvim").close()
                    return {}
                end,
                before_load = function(_, data)
                    vim.cmd("%bwipeout!")
                    return data
                end,
                after_load = function(_, _)
                    require("sidebar-nvim").open()
                    vim.cmd("TermRefresh")
                end,
            },
        },
    },

    {
        "sidebar-nvim/sidebar.nvim",
        cmd = { "SidebarNvimToggle", "SidebarNvimClose" },
        config = function()
            local harpoon = require("harpoon")

            local base_info = {
                title = "Info",
                icon = "",
                draw = function()
                    local lines = {}

                    -- Mode
                    local modes = {
                        ["n"] = "Normal",
                        ["no"] = "N·Operator Pending",
                        ["v"] = "Visual",
                        ["V"] = "V·Line",
                        [""] = "V·Block",
                        ["s"] = "Select",
                        ["S"] = "S·Line",
                        [""] = "S·Block",
                        ["i"] = "Insert",
                        ["R"] = "Replace",
                        ["Rv"] = "V·Replace",
                        ["c"] = "Command",
                        ["cv"] = "Vim Ex",
                        ["ce"] = "Ex",
                        ["r"] = "Prompt",
                        ["rm"] = "More",
                        ["r?"] = "Confirm",
                        ["!"] = "Shell",
                        ["t"] = "Terminal",
                    }
                    local mode = vim.fn.mode()
                    local mode_name = modes[mode]
                    table.insert(lines, "mode: " .. (mode_name and mode_name or "undefined"))

                    -- Git branch
                    if vim.fn.isdirectory(".git") then
                        local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
                        if branch ~= "" then
                            table.insert(lines, "branch: " .. branch)
                        end
                    end

                    return {
                        lines = lines,
                    }
                end,
            }

            local tabs = {
                title = "Tabs",
                icon = "",
                draw = function()
                    local tab_lines = {
                        "current tab: " .. vim.api.nvim_get_current_tabpage(),
                        "number of tabs: " .. #vim.api.nvim_list_tabpages(),
                    }
                    return {
                        lines = tab_lines,
                    }
                end,
            }

            local buffers = {
                title = "Buffers",
                icon = "",
                draw = function()
                    local lines = {}
                    local ls_cmd_output = vim.fn.execute("ls")
                    local cwd = vim.fn.getcwd() .. "/"
                    local current_buf = vim.api.nvim_buf_get_name(0):gsub("-", ""):gsub(cwd:gsub("-", ""), "")

                    for buf in string.gmatch(ls_cmd_output, '"%S+"') do
                        local buf_name = buf:gsub('"', ""):gsub(cwd:gsub("/home/aadi", "~"), "")

                        if buf_name:find("^term://") ~= nil then
                            goto continue
                        end

                        if buf_name == current_buf then
                            table.insert(lines, "> " .. buf_name)
                        else
                            table.insert(lines, "  " .. buf_name)
                        end

                        ::continue::
                    end
                    return {
                        lines = lines,
                    }
                end,
            }

            local terms = {
                title = "Terminals",
                icon = "",
                draw = function()
                    local lines = {}
                    local terminal_data = require("termnames").get_terminals()
                    if terminal_data then
                        local current_bufnr = vim.api.nvim_win_get_buf(0)
                        for _, term in ipairs(terminal_data) do
                            if term.bufnr == current_bufnr then
                                table.insert(lines, "> " .. term.name)
                            else
                                table.insert(lines, "  " .. term.name)
                            end
                        end
                    end
                    return {
                        lines = lines,
                    }
                end,
            }

            local harpoon_marks = {
                title = "Harpoon Marks",
                icon = "",
                draw = function()
                    local marks = harpoon.get_mark_config().marks
                    local keymaps = { "H ", "T ", "M ", "L " }
                    local lines = {}

                    for idx = 1, #marks do
                        if idx > 4 then
                            table.insert(lines, "  " .. marks[idx].filename)
                        else
                            table.insert(lines, keymaps[idx] .. marks[idx].filename)
                        end
                    end

                    return {
                        lines = lines,
                    }
                end,
            }

            vim.api.nvim_set_hl(0, "SidebarNvimSectionTitle", { fg = "#f9f5d7" })

            require("sidebar-nvim").setup({
                sections = { base_info, tabs, buffers, terms, harpoon_marks },
                update_interval = 0,
                hide_statusline = true,
            })

            vim.api.nvim_create_autocmd(
                { "BufAdd", "BufDelete", "BufEnter", "TabEnter", "ModeChanged", "DiagnosticChanged" },
                {
                    callback = function()
                        require("sidebar-nvim").update()
                    end,
                }
            )
        end,
    },

    {
        "simrat39/symbols-outline.nvim",
        cmd = "SymbolsOutline",
        config = function()
            require("symbols-outline").setup({
                show_symbol_details = false,
            })
        end,
    },

    {
        "mbbill/undotree",
        cmd = "UndotreeToggle",
        config = function()
            vim.g.undotree_WindowLayout = 3
            vim.g.undotree_SplitWidth = 40
        end,
    },

    { "famiu/bufdelete.nvim", cmd = { "Bdelete", "Bwipeout" } },

    {
        "aaditeynair/termnames.nvim",
        cmd = { "TermOpen", "TermRename", "TermClose", "TermRefresh", "TermSave" },
    },

    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
        opts = {
            auto_preview = false,
        },
    },
}
