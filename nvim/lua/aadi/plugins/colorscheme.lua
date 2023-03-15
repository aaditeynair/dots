return {
	{
		"eddyekofo94/gruvbox-flat.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.gruvbox_transparent = true
			vim.api.nvim_command("colorscheme gruvbox-flat")

			vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

			vim.api.nvim_set_hl(0, "StatusLine", { bg = nil, fg = "#5a524c", underline = true, bold = true })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = nil, fg = "#5a524c", underline = true })
			vim.cmd("let &statusline=' '")
		end,
	},
}
