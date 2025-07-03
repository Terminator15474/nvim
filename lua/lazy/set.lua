vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.expandtab = false
vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true

vim.opt.scrolloff = 20
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50
vim.opt.colorcolumn = "80" -- dark blue column after 80 chars

vim.opt.winblend = 15

vim.g.mapleader = " "

vim.diagnostic.config({ virtual_text = true, virtual_lines = true, severity_sort = true, update_in_insert = true })
