local lazydev_opts = {
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "wezterm-types",      mods = { "wezterm" } }, -- maybe unneeded
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
}

require('lazydev').setup(opts)



local capabilities = require('blink.cmp').get_lsp_capabilities()

require('mason').setup {}

require('mason-lspconfig').setup {
	ensure_installed = {
		'lua_ls',
		'gopls',
		'rust_analyzer',
		'powershell_es',
	},
	automatic_enable = true,
	handlers = {
		function(server)
			require('lspconfig')[server].setup {
				capabilities = capabilities
			}
		end,
		['emmet_language_server'] = function()
			require('lspconfig').emmet_language_server.setup {
				filetypes = { 'css', 'html', 'templ' },
				init_options = {
					---@type table<string, string>
					includeLanguages = { 'templ' },
					--- @type string[]
					excludeLanguages = {},
					--- @type string[]
					extensionsPath = {},
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
					preferences = {},
					--- @type boolean Defaults to `true`
					showAbbreviationSuggestions = true,
					--- @type 'always' | 'never' Defaults to `'always'`
					showExpandedAbbreviation = 'always',
					--- @type boolean Defaults to `false`
					showSuggestionsAsSnippets = false,
					--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
					syntaxProfiles = {},
					--- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
					variables = {},
				},
			}
		end
	}
}
