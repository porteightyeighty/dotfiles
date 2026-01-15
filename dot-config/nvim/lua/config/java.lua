local M = {}

-- Path to templates directory
local template_dir = vim.fn.fnamemodify(debug.getinfo(1, 'S').source:sub(2), ':h') .. '/templates'

-- Load a template file and substitute placeholders
local function load_template(name, substitutions)
	local path = template_dir .. '/' .. name
	local lines = vim.fn.readfile(path)
	local content = table.concat(lines, '\n')
	for key, value in pairs(substitutions or {}) do
		content = content:gsub('{{' .. key .. '}}', value)
	end
	return content
end

function M.create_project()
	vim.ui.input({ prompt = 'Project name (or path): ' }, function(input)
		if not input or input == '' then return end
		local project_dir = vim.fn.fnamemodify(input, ':p')
		local project_name = vim.fn.fnamemodify(project_dir, ':t')

		-- Create directory structure
		local dirs = {
			project_dir,
			project_dir .. '/src/main/java/com/' .. project_name,
			project_dir .. '/src/main/resources',
			project_dir .. '/src/test/java/com/' .. project_name,
			project_dir .. '/src/test/resources',
		}
		for _, dir in ipairs(dirs) do
			vim.fn.mkdir(dir, 'p')
		end

		-- Write files
		local subs = { PROJECT_NAME = project_name }
		local files = {
			{ path = project_dir .. '/pom.xml',                                               content = load_template('pom.xml', subs) },
			{ path = project_dir .. '/src/main/java/com/' .. project_name .. '/App.java',     content = load_template('App.java', subs) },
			{ path = project_dir .. '/src/test/java/com/' .. project_name .. '/AppTest.java', content = load_template('AppTest.java', subs) },
			{ path = project_dir .. '/.gitignore',                                            content = load_template('gitignore') },
		}
		for _, file in ipairs(files) do
			local f = io.open(file.path, 'w')
			if f then
				f:write(file.content)
				f:close()
			end
		end

		vim.notify('Created Maven project: ' .. project_name, vim.log.levels.INFO)
		vim.ui.select({ 'yes', 'no' }, { prompt = 'Project created! Open ' .. project_name .. '?' },
			function(choice)
				if choice == 'yes' then
					vim.cmd('cd ' .. project_dir)
					vim.cmd('edit .')
				else
					vim.notify('Project created at ' .. project_dir, vim.log.levels.INFO)
				end
			end)
	end)
end

function M.setup()
	vim.api.nvim_create_user_command('JavaNewProject', M.create_project, { desc = 'Create a new Java Maven project' })
end

return M
