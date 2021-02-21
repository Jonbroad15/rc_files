"set nocompatible              " required
"
filetype plugin on	      " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
"
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'jnurmine/Zenburn'
"Plugin 'tpope/vim-fugitive'
"Plugin 'scrooloose/nerdcommenter'
Plugin 'preservim/nerdcommenter'
"Plugin 'tomlion/vim-solidity'
"Plugin 'tpope/vim-surround'
"Plugin 'ervandew/supertab'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'lervag/vimtex'
"Plugin 'plasticboy/vim-markdown'
"Plugin 'godlygeek/tabular'
"Plugin 'vim-airline/vim-airline'
"Plugin 'git-time-metric/gtm-vim-plugin'
Plugin 'kshenoy/vim-signature'
"Plugin 'heavenshell/vim-pydocstring'
"Plugin 'dense-analysis/ale'
"Plugin 'sheerun/vim-wombat-scheme'
Plugin 'ParamagicDev/vim-medic_chalk'
"
" " Add all your plugins here (note older versions of Vundle used Bundle
" instead of Plugin)
"
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on "required

"python mode
let g:pymode = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_virtualenv = 1
let g:pymode_python = "python3"
let g:pymode_motion = 1
let g:pymode_rope = 1

"color
colorscheme medic_chalk

set relativenumber
set number
set scrolloff=20
imap ;; <Esc>
set rtp+=/Users/carlosgonzalezoliver/anaconda/lib/python2.7/site-packages/powerline/bindings/vim

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding
set foldmethod=indent
set foldlevel=99
let g:SimpylFold_docstring_preview=1
"use space to open folds
nnoremap <space> za

" Python indents

highlight BadWhitespace ctermbg=red guibg=red

au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix 

"au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2 softtabstop=2 shiftwidth=2

" Flag unnecessary whitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8

" For full syntax highlighting:
let python_highlight_all=1
syntax on

" " Keep indentation level from previous line:
"autocmd FileType python set autoindent

let mapleader = ","
let localleader = ","
nmap <leader>ne :NERDTree<cr>
map <Leader>nt :NERDTreeTabsToggle<CR>

" script execution
nmap <leader>py :w<CR>:!python %<CR>

" colorscheme
"colo koehler
"colorscheme sublimemonokai
syntax enable
set background=light
"colorscheme solarized

" set strong encryption
set cm=blowfish2

" bracket select
noremap % v%
set showmatch
set matchtime=3

"tagbar
nmap <leader>tb :TagbarToggle<CR>

"autocmd VimEnter * NERDTree
"autocmd VimEnter * TagbarToggle 
autocmd VimEnter * wincmd p

function! AirlineInit()
  if exists('*GTMStatusline')
    call airline#parts#define_function('gtmstatus', 'GTMStatusline')
    let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
  endif
endfunction
autocmd User AirlineAfterInit call AirlineInit()

"map <Esc> to jj
imap jj <Esc>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
