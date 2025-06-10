vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
	pattern = "*.wgsl",
	callback = function()
		vim.bo.filetype = "wgsl"
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

