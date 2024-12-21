return {
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',
		version = 'v0.*',

		opts = {
			keymap = { preset = 'super-tab', ['<UP>'] = { 'select_prev', 'fallback' }, ['<DOWN>'] = { 'select_next', 'fallback' } },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'mono',
			},
			sources = {
				default = { 'lazydev', 'lsp', 'path', 'buffer' },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			completion = {
				accept = { auto_brackets = { enabled = true } },
			},
			signature = { enabled = true },
		},
	}
}
