return {
	'mfussenegger/nvim-jdtls',
	ft = 'java',
	dependencies = {
		'mfussenegger/nvim-dap',
		'mason-org/mason.nvim',
	},
	config = function()
		local jdtls = require('jdtls')

		local function setup_jdtls()
			-- Find project root directory from current buffer
			local root_markers = { 'pom.xml', 'build.gradle', 'build.gradle.kts', '.git', 'mvnw', 'gradlew' }
			local root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true, path = vim.fn.expand('%:p:h') })[1])

			if not root_dir then
				vim.notify('JDTLS: Could not find project root', vim.log.levels.WARN)
				return
			end

			-- Workspace folder for JDTLS (stores index data per project)
			local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
			local workspace_dir = vim.fn.stdpath('cache') .. '/jdtls-workspace/' .. project_name

			-- Mason install paths (bypass registry API issues)
			local mason_path = vim.fn.stdpath('data') .. '/mason/packages'
			local jdtls_path = mason_path .. '/jdtls'

			if vim.fn.isdirectory(jdtls_path) == 0 then
				vim.notify('JDTLS: jdtls not installed. Run :MasonInstall jdtls', vim.log.levels.WARN)
				return
			end

			local launcher = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')

			local os_config
			if vim.fn.has('mac') == 1 then
				os_config = 'config_mac'
			elseif vim.fn.has('unix') == 1 then
				os_config = 'config_linux'
			else
				os_config = 'config_win'
			end
			local config_path = jdtls_path .. '/' .. os_config

			-- Lombok support
			local lombok_path = vim.fn.expand('~/.local/share/nvim/lombok.jar')
			local lombok_agent = vim.fn.filereadable(lombok_path) == 1
				and { '-javaagent:' .. lombok_path }
				or {}

			-- Debug adapter paths
			local bundles = {}

			local debug_path = mason_path .. '/java-debug-adapter'
			if vim.fn.isdirectory(debug_path) == 1 then
				local debug_jar = vim.fn.glob(debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
				if debug_jar ~= '' then
					table.insert(bundles, debug_jar)
				end
			end

			local test_path = mason_path .. '/java-test'
			if vim.fn.isdirectory(test_path) == 1 then
				local test_jars = vim.fn.glob(test_path .. '/extension/server/*.jar', true, true)
				for _, jar in ipairs(test_jars) do
					if not vim.endswith(jar, 'com.microsoft.java.test.runner-jar-with-dependencies.jar') then
						table.insert(bundles, jar)
					end
				end
			end

			-- Extended client capabilities
			local extendedClientCapabilities = jdtls.extendedClientCapabilities
			extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

			-- JDTLS command
			local cmd = {
				'java',
				'-Declipse.application=org.eclipse.jdt.ls.core.id1',
				'-Dosgi.bundles.defaultStartLevel=4',
				'-Declipse.product=org.eclipse.jdt.ls.core.product',
				'-Dlog.protocol=true',
				'-Dlog.level=ALL',
				'-Xmx1g',
				'--add-modules=ALL-SYSTEM',
				'--add-opens', 'java.base/java.util=ALL-UNNAMED',
				'--add-opens', 'java.base/java.lang=ALL-UNNAMED',
			}

			for _, arg in ipairs(lombok_agent) do
				table.insert(cmd, arg)
			end

			vim.list_extend(cmd, {
				'-jar', launcher,
				'-configuration', config_path,
				'-data', workspace_dir,
			})

			local config = {
				cmd = cmd,
				root_dir = root_dir,
				settings = {
					java = {
						signatureHelp = { enabled = true },
						contentProvider = { preferred = 'fernflower' },
						completion = {
							favoriteStaticMembers = {
								'org.junit.Assert.*',
								'org.junit.Assume.*',
								'org.junit.jupiter.api.Assertions.*',
								'org.junit.jupiter.api.Assumptions.*',
								'org.junit.jupiter.api.DynamicContainer.*',
								'org.junit.jupiter.api.DynamicTest.*',
								'org.mockito.Mockito.*',
								'org.mockito.ArgumentMatchers.*',
								'org.mockito.Answers.*',
							},
							filteredTypes = {
								'com.sun.*',
								'io.micrometer.shaded.*',
								'java.awt.*',
								'jdk.*',
								'sun.*',
							},
						},
						sources = {
							organizeImports = {
								starThreshold = 9999,
								staticStarThreshold = 9999,
							},
						},
						codeGeneration = {
							toString = {
								template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
							},
							hashCodeEquals = {
								useJava7Objects = true,
							},
							useBlocks = true,
						},
					},
				},
				init_options = {
					bundles = bundles,
					extendedClientCapabilities = extendedClientCapabilities,
				},
				on_attach = function(client, bufnr)
					jdtls.setup_dap({ hotcodereplace = 'auto' })
					require('jdtls.dap').setup_dap_main_class_configs()

					local opts = { buffer = bufnr, silent = true }

					vim.keymap.set('n', '<leader>jo', jdtls.organize_imports,
						vim.tbl_extend('force', opts, { desc = '[J]ava: [O]rganize Imports' }))
					vim.keymap.set('n', '<leader>jv', jdtls.extract_variable,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Extract [V]ariable' }))
					vim.keymap.set('v', '<leader>jv', function() jdtls.extract_variable(true) end,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Extract [V]ariable' }))
					vim.keymap.set('n', '<leader>jc', jdtls.extract_constant,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Extract [C]onstant' }))
					vim.keymap.set('v', '<leader>jc', function() jdtls.extract_constant(true) end,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Extract [C]onstant' }))
					vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method(true) end,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Extract [M]ethod' }))

					vim.keymap.set('n', '<leader>jt', jdtls.test_nearest_method,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Run [T]est (nearest)' }))
					vim.keymap.set('n', '<leader>jT', jdtls.test_class,
						vim.tbl_extend('force', opts, { desc = '[J]ava: Run All [T]ests (class)' }))

					vim.keymap.set('n', '<leader>jr', function()
						require('jdtls.dap').setup_dap_main_class_configs()
						require('dap').continue()
					end, vim.tbl_extend('force', opts, { desc = '[J]ava: [R]un Main Class' }))

					vim.keymap.set('n', '<leader>jb', function()
						local build_cmd
						if vim.fn.filereadable(root_dir .. '/pom.xml') == 1 then
							build_cmd = 'mvn compile -f ' .. root_dir .. '/pom.xml'
						elseif vim.fn.filereadable(root_dir .. '/build.gradle') == 1 or vim.fn.filereadable(root_dir .. '/build.gradle.kts') == 1 then
							build_cmd = 'cd ' .. root_dir .. ' && ./gradlew build'
						else
							vim.notify('No pom.xml or build.gradle found', vim.log.levels.WARN)
							return
						end
						vim.cmd('!' .. build_cmd)
					end, vim.tbl_extend('force', opts, { desc = '[J]ava: [B]uild Project' }))

					vim.keymap.set('n', '<leader>jR', function()
						jdtls.compile('full')
					end, vim.tbl_extend('force', opts, { desc = '[J]ava: [R]ebuild Workspace' }))
				end,
				capabilities = require('blink.cmp').get_lsp_capabilities(),
			}

			jdtls.start_or_attach(config)
		end

		-- Run for every Java buffer
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'java',
			callback = setup_jdtls,
		})

		-- Run immediately for the current buffer
		setup_jdtls()
	end,
}
