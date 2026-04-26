-------------------
-- Basic Keymaps --
-------------------

-- Visual line movement
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", function()
	vim.notify("Use h to move!!")
end)
vim.keymap.set("n", "<right>", function()
	vim.notify("Use l to move!!")
end)
vim.keymap.set("n", "<up>", function()
	vim.notify("Use k to move!!")
end)
vim.keymap.set("n", "<down>", function()
	vim.notify("Use j to move!!")
end)

-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bx", ":bdelete<CR>", { desc = "Close buffer" })

-- Splitting & Resizing
vim.keymap.set("n", "<leader>wv", ":vsplit<CR>", { desc = "Split [w]indow [v]ertically" })
vim.keymap.set("n", "<leader>wh", ":split<CR>", { desc = "Split [w]indow [h]orizontally" })
vim.keymap.set("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

---------------------
-- Command aliases --
---------------------

-- I really struggle not to keep shift held down while executing these commands, so papering over the cracks with this!
vim.cmd("command! Wq wq")
vim.cmd("command! WQ wq")
vim.cmd("command! W w")
vim.cmd("command! Q quit")
