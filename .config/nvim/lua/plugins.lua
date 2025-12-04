return {

  {
    "NeogitOrg/neogit",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
    }
  },

  { 'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function() 
      require 'config.telescope'
    end
  },

  { 'neovim/nvim-lspconfig',
    config = function()
      require 'config.lspconfig'
    end
  },

  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip'
    },
    config = function()
      require 'config.cmp'
    end
  },

  { 'scalameta/nvim-metals',
    config = function() require 'config.metals' end,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'j-hui/fidget.nvim'
    }
  },

  { 'lewis6991/gitsigns.nvim',
    tag = 'release',
    config = function() 
      require('gitsigns').setup { current_line_blame = true }
    end
  },

  { 'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require 'config.treesitter'
    end
  }

};
