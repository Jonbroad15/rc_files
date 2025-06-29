-- ~/.config/nvim/lua/plugins.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- GitHub Copilot
  {
    'github/copilot.vim',
    config = function()
      -- Enable Copilot when Neovim starts
      vim.cmd([[autocmd VimEnter * Copilot enable]])

    end,
  },
  -- Tree explorer
  { "preservim/nerdtree" },
  
  {'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end
  },

  -- Airline
  { "vim-airline/vim-airline" },
  { "vim-airline/vim-airline-themes" },

  -- Syntax and utilities
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('nvim-tree').setup({
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    })
    vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
  end,
},

    {'folke/tokyonight.nvim'},
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

})

