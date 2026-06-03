return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		signs = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged = {
			add = { text = "┃" },
			change = { text = "┃" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signs_staged_enable = true,
		signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
		numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
		linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
		word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
		watch_gitdir = {
			follow_files = true,
		},
		auto_attach = true,
		attach_to_untracked = false,
		current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
			delay = 1000,
			ignore_whitespace = false,
			virt_text_priority = 100,
			use_focus = true,
		},
		current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
		blame_formatter = nil, -- Use default
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		max_file_length = 40000, -- Disable if file is longer than this (in lines)
		preview_config = {
			-- Options passed to nvim_open_win
			style = "minimal",
			relative = "cursor",
			row = 0,
			col = 1,
		},
		on_attach = function(bufnr)
			local gs = require("gitsigns")
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end

			-- Register the +Git clue group buffer-locally so mini.clue only shows
			-- it where these maps actually exist (i.e. git-tracked buffers).
			-- mini.clue concatenates buffer-local clues with the global ones.
			vim.b[bufnr].miniclue_config = {
				clues = {
					{ mode = "n", keys = "<Leader>g", desc = "+Git" },
					{ mode = "x", keys = "<Leader>g", desc = "+Git" },
				},
			}

			-- Hunk navigation (]c/[c are taken by mini.bracketed comments)
			map("n", "]h", function()
				gs.nav_hunk("next")
			end, "Next [H]unk")
			map("n", "[h", function()
				gs.nav_hunk("prev")
			end, "Prev [H]unk")

			-- Stage / reset
			map("n", "<leader>gs", gs.stage_hunk, "[G]it [S]tage hunk")
			map("n", "<leader>gr", gs.reset_hunk, "[G]it [R]eset hunk")
			map("x", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "[G]it [S]tage selection")
			map("x", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "[G]it [R]eset selection")
			map("n", "<leader>gS", gs.stage_buffer, "[G]it [S]tage buffer")
			map("n", "<leader>gR", gs.reset_buffer, "[G]it [R]eset buffer")

			-- Inspect
			map("n", "<leader>gp", gs.preview_hunk, "[G]it [P]review hunk")
			map("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end, "[G]it [B]lame line")
			map("n", "<leader>gB", gs.toggle_current_line_blame, "[G]it toggle line [B]lame")

			-- Diff current file
			map("n", "<leader>gd", gs.diffthis, "[G]it [D]iff this")
			map("n", "<leader>gD", function()
				gs.diffthis("~")
			end, "[G]it [D]iff this (against last commit)")

			-- Hunk text object (e.g. dih / vih)
			map({ "o", "x" }, "ih", gs.select_hunk, "Inner [H]unk")
		end,
	},
}
