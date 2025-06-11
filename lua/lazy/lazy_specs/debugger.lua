return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local dap, dapui = require("dap"), require("dapui")

		dapui.setup()

		dap.adapters.codelldb = {
			type = 'server',
			port = "${port}",

			executable = {
				command = vim.fn.exepath('codelldb'),
				args = { "--port", "${port}" },
			},
		}

		dap.configurations.rust = {
			{
				name = "Rust debug",
				type = "codelldb",
				request = "launch",

				cwd = '${workspaceFolder}',
				stopOnEntry = false,
				showDisassembly = "never",
				sourceLanguages = { "rust" },

				program = function()
					vim.fn.jobstart('cargo build')
					local cmd = "fd --type f \".exe\" --absolute-path --no-ignore --hidden -d 1"
					local co = coroutine.running() or error("Must run in coroutine")
					local selected_path = nil

					require("fzf-lua").fzf_exec(cmd, {
						cwd = vim.fn.getcwd() .. "\\target\\debug\\",
						ignore_current_file = true,
						no_ignore = true,
						actions = {
							['default'] = function(selected, opts)
								selected_path = selected[1]
								coroutine.resume(co)
							end,
							['esc'] = function()
								selected_path = nil
								coroutine.resume(co)
							end,
						},
						winopts = {
							preview = { hidden = true },
						},
					})

					coroutine.yield()
					vim.g.dap_file = selected_path
					if vim.g.dap_file then
						vim.notify("Debugging " .. vim.g.dap_file)
						return vim.g.dap_file
					else
						vim.notify("Error when loading file to debug")
						return ""
					end
				end,
			}
		}


		local keymap_restore = {}
		dap.listeners.after['event_initialized']['me'] = function()
			for _, buf in pairs(vim.api.nvim_list_bufs()) do
				local keymaps = vim.api.nvim_buf_get_keymap(buf, 'n')
				for _, keymap in pairs(keymaps) do
					if keymap.lhs == "K" then
						table.insert(keymap_restore, keymap)
						vim.api.nvim_buf_del_keymap(buf, 'n', 'K')
					end
				end
			end
			vim.api.nvim_set_keymap(
				'n', 'K', '<Cmd>lua require("dap.ui.widgets").hover()<CR>', { silent = true })
		end

		dap.listeners.after['event_terminated']['me'] = function()
			for _, keymap in pairs(keymap_restore) do
				if keymap.rhs then
					vim.api.nvim_buf_set_keymap(
						keymap.buffer,
						keymap.mode,
						keymap.lhs,
						keymap.rhs,
						{ silent = keymap.silent == 1 }
					)
				elseif keymap.callback then
					vim.keymap.set(
						keymap.mode,
						keymap.lhs,
						keymap.callback,
						{ buffer = keymap.buffer, silent = keymap.silent == 1 }
					)
				end
			end
			keymap_restore = {}
		end


		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.after.event_initialized.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
		vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })
	end
}
