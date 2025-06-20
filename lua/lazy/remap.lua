vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")


vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

vim.api.nvim_create_augroup("AutoFormat", {})
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{
		group = "AutoFormat",
		callback = function()
			vim.lsp.buf.format()
		end,
	}
)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)


vim.keymap.set('n', '<leader>w', '<C-W>')

vim.keymap.set({ "n", "v" }, "<leader>ud", function()
	vim.cmd.UndotreeToggle()
	vim.cmd.UndotreeFocus()
end)

vim.keymap.set("n", "<leader>to", "<cmd>TransparentToggle<cr>")

vim.api.nvim_create_augroup("Remaps", {})
vim.api.nvim_create_autocmd("LspAttach", {
	group = "Remaps",
	callback = function()
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition)
		vim.keymap.set("i", "<C-h>", "<c>ldbi")
		vim.keymap.set("i", "<C-Del>", "<esc>ldwi")
	end
})

-- Debugging stuff
-- Mnemonic breakpoints
vim.keymap.set({ "n" }, "<leader>bb", require("dap").toggle_breakpoint)
vim.keymap.set({ "n" }, "<C-n>", require("dap").step_over)
-- Mnemonic List breakpoints
vim.keymap.set({ "n" }, "<leader>bl", require("dap").list_breakpoints)
vim.keymap.set({ "n" }, "<leader>bi", require("dap").step_into)
-- Mnemonic: debug (continue starts the debug)
vim.keymap.set({ "n" }, "<leader>dbg", require("dap").continue)
