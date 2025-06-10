return {
	cmd = { "wgsl-analyzer" },
	filetypes = { "wgsl" },
	root_markers = { ".git", "*.wgsl" },
	settings = {
		["wgsl-analyzer"] = {
			server = {
				path = "~/.cargo/bin/wgsl-analyzer.exe",
			},
			diagnostics = {
				typeErrors = true,
				nagaParsing = true,
				nagaValidation = true,
				nagaVersion = "main",
			},
			inlayHints = {
				enabled = true,
				typeHints = true,
				parameterHints = true,
				structLayoutHints = true,
				typeVerbosity = "compact",

			},
		}
	},
}
