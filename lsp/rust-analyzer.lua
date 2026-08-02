return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_dirs = { "Cargo.toml", "rust-project.json", ".git" },
	settings = {
		["rust-analyzer"] = {
			cargo = {
				allFeatures = true,
			},
		},
	},
}
