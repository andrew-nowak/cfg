local status, packer = pcall(require, "packer")
if (not status) then
  print("Packer is not installed")
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  --use { 'junegunn/fzf.vim', requires = {'junegunn/fzf'}, config = function() vim.cmd [[
  --  source setup-fzf.vim
  --]] end }

  use { 'nvim-telescope/telescope.nvim', tag = '0.1.5',
    requires = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = [[require 'config.telescope']]
  }

  use { 'neovim/nvim-lspconfig',
    config = [[require 'config.lspconfig']],
    --run = [[npm install -g typescript-language-server@1.0.0]]
  }

  use { 'hrsh7th/nvim-cmp', config = [[require 'config.cmp']],
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip'
    }
  }

  use { 'scalameta/nvim-metals', config = [[require 'config.metals']],
    requires = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp'
    }
  }

  use { 'lewis6991/gitsigns.nvim', tag = 'release',
    config = [[require('gitsigns').setup { current_line_blame = true }]] }

  use { 'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = [[require 'config.treesitter']]
  }

end)
