return {
	{
		'https://github.com/lewis6991/gitsigns.nvim',
		config = function()
			local gs = require('gitsigns')
			gs.setup {}
			gs.toggle_current_line_blame(true)
		end
	}
}
