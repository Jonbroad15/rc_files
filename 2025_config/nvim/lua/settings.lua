-- ~/.config/nvim/lua/settings.lua
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.scrolloff = 20
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.encoding = "utf-8"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.showmatch = true
vim.opt.matchtime = 3
vim.g.pymode_python = 'python3'
vim.g.pymode_lint = 0
vim.cmd("syntax enable")
vim.cmd("filetype plugin indent on")
vim.cmd('colorscheme catppuccin-latte')


