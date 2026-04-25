---------------
-- Telescope --
---------------
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<cr>", { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<cr>", { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", "<cmd>Telescope builtin<cr>", { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", "<cmd>Telescope grep_string<cr>", { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<cr>", { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", "<cmd>Telescope resume<cr>", { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", "<cmd>Telescope oldfiles<cr>", { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sn", function()
	require("telescope.builtin").live_grep({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim Files" })
vim.keymap.set("n", "<leader><leader>", "<cmd>Telescope buffers<cr>", { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "[/] Fuzzy Find in Buffer" })

---------
-- Oil --
---------

vim.keymap.set("n", "\\", "<cmd>Oil --float .<CR>", { desc = "Open Oil file browser in cwd" })

------------------
-- Notifications --
------------------

vim.keymap.set("n", "<leader>nh", function()
	Snacks.notifier.show_history()
end, { desc = "[N]otification [H]istory" })

---------
-- DAP --
---------

vim.keymap.set("n", "<F5>", function()
	require("dap").continue()
end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", function()
	require("dap").step_over()
end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function()
	require("dap").step_into()
end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function()
	require("dap").step_out()
end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "[D]ebug: Step [O]ver" })
vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "[D]ebug: Step [I]nto" })
vim.keymap.set("n", "<leader>dO", function()
	require("dap").step_out()
end, { desc = "[D]ebug: Step [O]ut" })
vim.keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug: Toggle [B]reakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Conditional [B]reakpoint" })
vim.keymap.set("n", "<leader>dr", function()
	require("dap").repl.open()
end, { desc = "[D]ebug: Open [R]EPL" })
vim.keymap.set("n", "<leader>dl", function()
	require("dap").run_last()
end, { desc = "[D]ebug: Run [L]ast" })
vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "[D]ebug: Toggle [U]I" })

---------
-- LSP --
---------

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, desc = desc })
		end

		-- Navigation
		map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
		map("n", "gr", vim.lsp.buf.references, "[G]oto [R]eferences")
		map("n", "gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
		map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

		-- Documentation
		map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "<C-K>", vim.lsp.buf.signature_help, "Signature Help")

		-- Refactoring
		map("n", "<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
		vim.keymap.set({ "n", "x" }, "<leader>re", function()
			return require("refactoring").refactor("Extract Function")
		end, { desc = "[R]efactor: [E]xtract", expr = true })
		vim.keymap.set({ "n", "x" }, "<leader>rf", function()
			return require("refactoring").refactor("Extract Function To File")
		end, { desc = "[R]efactor: Extract to [F]ile", expr = true })
		vim.keymap.set({ "n", "x" }, "<leader>rv", function()
			return require("refactoring").refactor("Extract Variable")
		end, { desc = "[R]efactor: Extract [V]ariable", expr = true })
		vim.keymap.set({ "n", "x" }, "<leader>rI", function()
			return require("refactoring").refactor("Inline Function")
		end, { desc = "[R]efactor: [I]nline Function", expr = true })
		vim.keymap.set({ "n", "x" }, "<leader>ri", function()
			return require("refactoring").refactor("Inline Variable")
		end, { desc = "[R]efactor: [I]nline Variable", expr = true })
		vim.keymap.set({ "n", "x" }, "<leader>rb", function()
			return require("refactoring").refactor("Extract Block")
		end, { desc = "[R]efactor: Extract [B]lock", expr = true })
		vim.keymap.set({ "n", "x" }, "<leader>rB", function()
			return require("refactoring").refactor("Extract Block To File")
		end, { desc = "[R]efactor: Extract [B]lock to File", expr = true })

		-- You can also use below = true here to to change the position of the printf
		-- statement (or set two remaps for either one). This remap must be made in normal mode.
		vim.keymap.set("n", "<leader>rpf", function()
			require("refactoring").debug.printf({ below = false })
		end, { desc = "[R]efactor: Print Var" })

		-- Supports both visual and normal mode
		vim.keymap.set({ "x", "n" }, "<leader>rpv", function()
			require("refactoring").debug.print_var()
		end, { desc = "[R]efactor: Print Var" })

		-- Supports only normal mode
		vim.keymap.set("n", "<leader>rc", function()
			require("refactoring").debug.cleanup({})
		end)

		-- Code actions
		vim.keymap.set({ "n", "x" }, "<leader>ca", function()
			require("tiny-code-action").code_action()
		end, { noremap = true, silent = true })
		-- Workspace
		map("n", "<leader>cw", vim.lsp.buf.workspace_symbol, "[C]ode [W]orkspace Symbols")

		-- Inlay hints
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client and client:supports_method("textDocument/inlayHint") then
			vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
			map("n", "<leader>ch", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }), { bufnr = ev.buf })
			end, "[C]ode Inlay [H]ints Toggle")
		end
	end,
})
