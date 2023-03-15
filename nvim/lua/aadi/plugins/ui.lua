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
				"██╗       ██╗███████╗██╗      █████╗  █████╗ ███╗   ███╗███████╗   █████╗  █████╗ ██████╗ ██╗",
				"██║  ██╗  ██║██╔════╝██║     ██╔══██╗██╔══██╗████╗ ████║██╔════╝  ██╔══██╗██╔══██╗██╔══██╗██║",
				"╚██╗████╗██╔╝█████╗  ██║     ██║  ╚═╝██║  ██║██╔████╔██║█████╗    ███████║███████║██║  ██║██║",
				" ████╔═████║ ██╔══╝  ██║     ██║  ██╗██║  ██║██║╚██╔╝██║██╔══╝    ██╔══██║██╔══██║██║  ██║██║",
				" ╚██╔╝ ╚██╔╝ ███████╗███████╗╚█████╔╝╚█████╔╝██║ ╚═╝ ██║███████╗  ██║  ██║██║  ██║██████╔╝██║",
				"  ╚═╝   ╚═╝  ╚══════╝╚══════╝ ╚════╝  ╚════╝ ╚═╝     ╚═╝╚══════╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝",
				"",
			}

			dashboard.section.buttons.val = {
				dashboard.button("SPC r s", " Load Last Session", ":PossessionLoad<CR>"),
				dashboard.button("SPC s s", " List All Sessions", ":Telescope possession list<CR>"),
				dashboard.button("SPC SPC", " Search Files", ":Telescope find_files<CR>"),
				dashboard.button("SPC f s", " Search For Word", ":Telescope grep_string<CR>"),
				dashboard.button("SPC f f", " File Explorer", ":Telescope file_browser<CR>"),
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
}
