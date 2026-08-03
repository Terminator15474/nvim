---@diagnostic disable: missing-fields
require('neo-tree').setup({
	close_if_last_window = true,
	filesystem = {
		hijack_netrw_behavior = 'disabled'
	}
})
