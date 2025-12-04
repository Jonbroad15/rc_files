-- ~/.config/nvim/lua/keymaps.lua

-- switch panes with Ctrl + H/J/K/L
vim.api.nvim_set_keymap("n", "<C-J>", "<C-W><C-J>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-K>", "<C-W><C-K>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-L>", "<C-W><C-L>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-H>", "<C-W><C-H>", { noremap = true })

-- Resize windows using leader + arrow keys
vim.keymap.set("n", "<leader><Up>", ":resize -2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><Down>", ":resize +2<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><Left>", ":vertical resize -5<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><Right>", ":vertical resize +5<CR>", { noremap = true, silent = true })


-- nvim tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Script execution
vim.api.nvim_set_keymap("n", "<leader>py", ":w<CR>:!python %<CR>", { noremap = true })

-- Bracket match
vim.api.nvim_set_keymap("n", "<space>", "za", { noremap = true })
vim.api.nvim_set_keymap("n", "<CR>", "o<Esc>0\"_D", { noremap = true })

-- Copilot word suggestion
vim.cmd([[
function! SuggestOneWord()
    let suggestion = copilot#Accept("")
    let bar = copilot#TextQueuedForInsertion()
    return split(bar, '[ .]\zs')[0]
endfunction
imap <script><expr> <C-w> SuggestOneWord()
]])

