vim.cmd("colorscheme tokyonight")

local colorschemes = {
	'tokyonight-moon',
	'tokyonight-storm',
	'tokyonight-night',
	'flow',
	'catppuccin-mocha',
	'catppuccin-macchiato',
	'catppuccin-frappe',
	'rose-pine-moon',
	'kanagawa',
	'nord',
	'ashen',
	-- maybe extend in the future
}

function set_random_color(opts)
	local idx = vim.fn.rand() % #colorschemes
	local active_colors = vim.g.colors_name

	if colorschemes[idx + 1] ~= active_colors then
		vim.cmd("colorscheme " .. colorschemes[idx + 1])
		vim.notify("Switched colorscheme to \"" .. colorschemes[idx + 1] .. "\"", vim.log.levels.INFO,
			{ id = "colorscheme", title = "Colorscheme Changed" })
	else
		set_random_color(opts)
		vim.notify("Retrying colors", vim.log.levels.TRACE, { id = "colorscheme retry" })
	end
end

vim.api.nvim_create_user_command('RandomColors', set_random_color, {})
