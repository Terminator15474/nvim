return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"saghen/blink.cmp",
		},
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
				automatic_installation = true,
				handlers = {
					function(server)
						require("lspconfig")[server].setup {
							capabilities = capabilities
						}
					end,
				}
			}
		end
	},
	{
		'lervag/vimtex',
		lazy = false,
		init = function()
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
				_ = '-lualatex'
			}
		end
	}
}
