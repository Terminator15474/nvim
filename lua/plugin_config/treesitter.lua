require('nvim-treesitter').setup({
	-- A list of parser names, or 'all'
	ensure_installed = {
		'vimdoc', 'javascript', 'typescript', 'c', 'lua', 'rust',
		'jsdoc', 'bash',
	},

	ignore_install = { 'tex' },

	sync_install = false,
	auto_install = true,
	indent = {
		enable = true
	},

	highlight = {
		enable = true,
		disable = function(lang)
			if lang == 'html' or lang == 'tex' then
				vim.notify_once('Disabled Treesitter because file is of type' .. lang)
				return true
			end
		end,
		additional_vim_regex_highlighting = { 'markdown' },
	},
	modules = {}
})

local parser = require('nvim-treesitter.parsers')
parser.templ = {
	install_info = {
		url = 'https://github.com/vrischmann/tree-sitter-templ.git',
		files = { 'src/parser.c', 'src/scanner.c' },
		branch = 'master',
	}
}

vim.treesitter.language.register('templ', 'templ')


vim.api.nvim_create_autocmd('FileType', {
	callback = function(args) 
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
		end
	end
})
