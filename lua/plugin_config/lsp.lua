local opts = {
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "wezterm-types",      mods = { "wezterm" } }, -- maybe unneeded
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
		{ "nvim-dap-ui" },
	},
}

require('lazydev').setup()


require('mason').setup {}

require('mason-lspconfig').setup {
	ensure_installed = {
		'lua_ls',
		'gopls',
		'rust_analyzer',
		'powershell_es',
	},
	automatic_enable = {
		exlude = {
			"lua_ls",
			"wgsl-analyzer",
		}
	},
}
