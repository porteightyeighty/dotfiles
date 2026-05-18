-- Follow the markdown link/autolink/image/file under the cursor with `gx`.
-- Falls back to vim's default <cfile> behavior when no link node is found.

local function get_link_destination()
	local ok, node = pcall(vim.treesitter.get_node)
	if not ok or not node then
		return nil
	end

	while node do
		local t = node:type()
		if t == "inline_link" or t == "image" then
			for child in node:iter_children() do
				if child:type() == "link_destination" then
					return vim.treesitter.get_node_text(child, 0)
				end
			end
		elseif t == "uri_autolink" then
			return vim.treesitter.get_node_text(node, 0):sub(2, -2)
		elseif t == "email_autolink" then
			return "mailto:" .. vim.treesitter.get_node_text(node, 0):sub(2, -2)
		end
		node = node:parent()
	end
	return nil
end

local function follow_link()
	local dest = get_link_destination()

	if not dest then
		local cfile = vim.fn.expand("<cfile>")
		if cfile ~= "" then
			pcall(vim.ui.open, cfile)
		end
		return
	end

	-- Any URL-like scheme (http:, https:, mailto:, file:, etc.) → OS handler
	if dest:match("^%a[%w+.-]*:") then
		pcall(vim.ui.open, dest)
		return
	end

	-- Pure anchor (#heading) — nothing to follow externally
	if dest:match("^#") then
		return
	end

	-- Strip any anchor fragment before resolving as a file path
	local path = dest:gsub("#.*$", "")

	-- Resolve relative to the current file's directory
	local resolved
	if path:sub(1, 1) == "/" or path:sub(1, 1) == "~" then
		resolved = vim.fn.expand(path)
	else
		resolved = vim.fn.expand("%:p:h") .. "/" .. path
	end

	vim.cmd.edit(vim.fn.fnameescape(vim.fn.fnamemodify(resolved, ":p")))
end

vim.keymap.set("n", "gx", follow_link, { buffer = true, desc = "Follow markdown link / open file" })
