vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.wgsl",
	callback = function()
		vim.bo.filetype = "wgsl"
		vim.bo.commentstring = "// %s";
	end,
})


vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = { "*.MD", "*.md" },
	callback = function()
		vim.bo.filetype = "markdown"
		vim.bo.commentstring = "<!-- %s -->";
	end,
})

vim.lsp.enable {
	"lua_ls",
	"zls",
	"rust-analyzer",
	"wgsl_analyzer"
	-- "gopls",
	-- "powershelles",
	-- "emmyluals",
}
