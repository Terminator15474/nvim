return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				dependencies = {
					'gonstoll/wezterm-types'
				},
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "wezterm-types",      mods = { "wezterm" } },
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("mason").setup {}
			require("mason-lspconfig").setup {
				ensure_installed = {
					"lua_ls",
					"gopls",
					"rust_analyzer",
					"powershell_es",
				},
				automatic_enable = true,
				handlers = {
					function(server)
						require("lspconfig")[server].setup {
							capabilities = capabilities
						}
					end,
					['emmet_language_server'] = function()
						require("lspconfig").emmet_language_server.setup {
							filetypes = { "css", "html", "templ" },
							init_options = {
								---@type table<string, string>
								includeLanguages = { "templ" },
								--- @type string[]
								excludeLanguages = {},
								--- @type string[]
								extensionsPath = {},
								--- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
								preferences = {},
								--- @type boolean Defaults to `true`
								showAbbreviationSuggestions = true,
								--- @type "always" | "never" Defaults to `"always"`
								showExpandedAbbreviation = "always",
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
		end
	},
	{
		'lervag/vimtex',
		event = { "BufReadPre *.tex", "BufNewFile *.tex" },
		config = function()
			vim.g.vimtex_view_method = "general"
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_compiler_latexmk = {
				options = {
					"-verbose",
					"-synctex=1",
					"--shell-escape",
				}
			}
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = '-lualatex -interaction=nonstopmode'
			}
		end
	}
}
