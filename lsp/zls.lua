return {
	cmd = { "zls" },
	filetypes = { "zig" },
	root_dirs = { "build.zig", "build.zig.zon", ".git" },
	settings = {
		zls = {
			semantic_tokens = "partial",
		},
	},
}
