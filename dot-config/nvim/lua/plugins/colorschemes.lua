return {
    {'nanotech/jellybeans.vim'},
    {'everviolet/nvim', name = 'evergarden',
  priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
	   config = function ()
	 vim.cmd.colorscheme  'evergarden-winter'
	   end},
    {'catppuccin/nvim', name = 'catppuccin'},
    {'Pearljak/terracotta.nvim'}
}
