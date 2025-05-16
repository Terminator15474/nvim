return {
	cmd = { "powershell-editor-services" },
	filetypes = { "ps1", "psm1", "psd1" },
	root_dirs = { ".git", "*.ps1" },
	settings = {
		powershell = {
			codeFormatting = {
				Preset = "Allman",
			},
			scriptAnalysis = {
				enable = true,
			},
		},
	},

}
