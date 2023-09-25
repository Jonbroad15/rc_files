
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

call plug#begin()
Plug 'ParamagicDev/vim-medic_chalk'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'glepnir/dashboard-nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-lua/plenary.nvim'
Plug 'ojroques/vim-oscyank', {'branch': 'main'}
Plug 'LukeGoodsell/nextflow-vim'
Plug 'vim-scripts/Align'
Plug 'roxma/vim-tmux-clipboard'
call plug#end()

source ~/.vimrc
