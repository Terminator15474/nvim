return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio"
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

				-- program = function()
				-- 	vim.fn.jobstart('cargo build')
				-- 	local cmd = "fd --type f \".exe\" --absolute-path --no-ignore --hidden -d 1"
				--
				-- 	require("fzf-lua").fzf_exec(cmd, {
				-- 		cwd = vim.fn.getcwd() .. "\\target\\debug\\",
				-- 		ignore_current_file = true,
				-- 		no_ignore = true,
				-- 		actions = {
				-- 			['default'] = function(selected, opts)
				-- 				vim.g.dap_file = selected[1]
				-- 			end
				-- 		},
				-- 		winopts = {
				-- 			preview = { hidden = true },
				-- 		},
				-- 	})
				-- 	if vim.g.dap_file then
				-- 		vim.notify("Debugging " .. vim.g.dap_file)
				-- 		return vim.g.dap_file
				-- 	else
				-- 		vim.notify("Error when loading file to debug")
				-- 		return ""
				-- 	end
				-- end,

				cwd = '${workspaceFolder}',
				stopOnEntry = true,
				showDisassembly = "never",

				-- initCommands = function()
				-- 	local rustc_sysroot = vim.fn.trim(vim.fn.system 'rustc --print sysroot')
				-- 	assert(
				-- 		vim.v.shell_error == 0,
				-- 		'failed to get rust sysroot using `rustc --print sysroot`: '
				-- 		.. rustc_sysroot
				-- 	)
				-- 	local script_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_lookup.py'
				-- 	local commands_file = rustc_sysroot .. '/lib/rustlib/etc/lldb_commands'
				--
				-- 	-- The following is a table/list of lldb commands, which have a syntax
				-- 	-- similar to shell commands.
				-- 	--
				-- 	-- To see which command options are supported, you can run these commands
				-- 	-- in a shell:
				-- 	--
				-- 	--   * lldb --batch -o 'help command script import'
				-- 	--   * lldb --batch -o 'help command source'
				-- 	--
				-- 	-- Commands prefixed with `?` are quiet on success (nothing is written to
				-- 	-- debugger console if the command succeeds).
				-- 	--
				-- 	-- Prefixing a command with `!` enables error checking (if a command
				-- 	-- prefixed with `!` fails, subsequent commands will not be run).
				-- 	--
				-- 	-- NOTE: it is possible to put these commands inside the ~/.lldbinit
				-- 	-- config file instead, which would enable rust types globally for ALL
				-- 	-- lldb sessions (i.e. including those run outside of nvim). However,
				-- 	-- that may lead to conflicts when debugging other languages, as the type
				-- 	-- formatters are merely regex-matched against type names. Also note that
				-- 	-- .lldbinit doesn't support the `!` and `?` prefix shorthands.
				-- 	return {
				-- 		([[!command script import '%s']]):format(script_file),
				-- 		([[command source '%s']]):format(commands_file),
				-- 	}
				-- end
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
