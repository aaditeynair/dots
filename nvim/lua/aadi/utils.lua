function AutoBackground()
	local hour = tonumber(os.date("%H"))

	if hour >= 18 then
		vim.opt.background = "dark"
	elseif hour >= 7 then
		vim.opt.background = "light"
	else
		vim.opt.background = "dark"
	end
end
