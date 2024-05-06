-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.6',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

   use ({
	'sainnhe/everforest',
	config = function()
		vim.cmd('colorscheme everforest')
		if vim.fn.has('termguicolors') == 1 then
			vim.opt.termguicolors = true
		end

		-- Set the background to light
		vim.opt.background = 'dark'

		-- Set Everforest options
		vim.g.everforest_background = 'hard'
		vim.g.everforest_better_performance = 1
	end
  })

  use {
	"rose-pine/neovim",
	as = "rose-pine",
	config = function()
		vim.cmd('colorscheme rose-pine')
	end
  }

  use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
  }

  use {
	'nvim-treesitter/playground'
  }

  use {
	  'theprimeagen/harpoon'
  }

  use {
	  'mbbill/undotree'
  }

  use {
	  'tpope/vim-fugitive'
  }

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v3.x',
	  requires = {
		  --- Uncomment the two plugins below if you want to manage the language servers from neovim
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  {'neovim/nvim-lspconfig'},
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'L3MON4D3/LuaSnip'},
	  }
  }

  use {
      'raimondi/delimitmate'
  }

end)
