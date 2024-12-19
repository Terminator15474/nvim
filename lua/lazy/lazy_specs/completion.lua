return {
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',
		version = 'v0.*',

		opts = {
			keymap = { preset = 'super-tab' },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono',
			},
			sources = {
				defaults = { 'lsp' },
			},
			signature = { enabled = true },
		},
	}
}
