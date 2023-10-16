
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.keymap.set('n','<leader>pp', vim.cmd.Ex)
vim.keymap.set('n', 'U', '<C-r>')
vim.keymap.set('n', 'W', '$')
vim.keymap.set('n', 'B', '0')

vim.keymap.set('n', '<Left>', '<Nop>')
vim.keymap.set('n', '<Right>', '<Nop>')
vim.keymap.set('n', '<Up>', '<Nop>')
vim.keymap.set('n', '<Down>', '<Nop>')

vim.keymap.set('i', '<Left>', '<Nop>')
vim.keymap.set('i', '<Right>', '<Nop>')
vim.keymap.set('i', '<Up>', '<Nop>')
vim.keymap.set('i', '<Down>', '<Nop>')

vim.o.number = true
vim.o.relativenumber =true

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer
	use 'wbthomason/packer.nvim'


        use { 'Shougo/deoplete.nvim', { run = ':UpdateRemotePlugins' }}
	use 'ionide/Ionide-vim'

	use {
		'numToStr/Comment.nvim',
		config = function()
			require('Comment').setup()
		end
	}
	-- ColorScheme
	use({ 'rose-pine/neovim', as = 'rose-pine' })
	use 'navarasu/onedark.nvim'
	require('onedark').load()

-- Tree Sitter
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

	-- Telescope
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.2',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	local t_builtin = require('telescope.builtin')
	vim.keymap.set('n', '<leader>ff', t_builtin.find_files, {})
	vim.keymap.set('n', '<leader>fg', t_builtin.live_grep, {})
	vim.keymap.set('n', '<leader>fb', t_builtin.buffers, {})
	vim.keymap.set('n', '<leader>fh', t_builtin.help_tags, {})

	-- Harpoon
	use 'ThePrimeagen/harpoon'
	local h_mark = require("harpoon.mark")
	local h_ui = require("harpoon.ui")

	vim.keymap.set("n", "<leader>a", h_mark.add_file)
	vim.keymap.set("n", "<C-e>", h_ui.toggle_quick_menu)

	vim.keymap.set("n", "<C-h>", function() h_ui.nav_file(1) end)
	vim.keymap.set("n", "<C-t>", function() h_ui.nav_file(2) end)
	vim.keymap.set("n", "<C-n>", function() h_ui.nav_file(3) end)
	vim.keymap.set("n", "<C-s>", function() h_ui.nav_file(4) end)

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if packer_bootstrap then
		require('packer').sync()
	end
end)




