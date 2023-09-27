"filetype plugin indent on "required
let g:copilot_filetypes = { 
            \ 'markdown': v:true,
            \ 'gitcommit': v:true,
            \ 'yaml': v:true,
            \ 'nextflow': v:true}
"Luke goodsell vim plug for nextflow
"set colorcolumn=0

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

"set relative numbers
set relativenumber
set number
set scrolloff=20

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

" Snakemake
au BufNewFile,BufRead Snakefile set syntax=snakemake
au BufNewFile,BufRead *.rules set syntax=snakemake
au BufNewFile,BufRead *.snakefile set syntax=snakemake
au BufNewFile,BufRead *.snake set syntax=snakemake
au BufNewFile,BufRead *.smk set syntax=snakemake

" Python indents
highlight BadWhitespace ctermbg=red guibg=red
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent fileformat=unix 

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
nmap <leader>rs :w<CR>:!cargo build<CR>
nmap <leader>nf :w<CR>:!nextflow run %<CR>

" colorscheme
"colo koehler
"colorscheme sublimemonokai
syntax enable
"set background=light
"colorscheme solarized

" set strong encryption
" set cm=blowfish2

" bracket select
noremap % v%
set showmatch
set matchtime=3


autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

function! AirlineInit()
  if exists('*GTMStatusline')
    call airline#parts#define_function('gtmstatus', 'GTMStatusline')
    let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
  endif
endfunction
autocmd User AirlineAfterInit call AirlineInit()

filetype plugin indent on
" show existing tab with 4 spaces width
 set tabstop=4
" " when indenting with '>', use 4 spaces width
 set shiftwidth=4
" " On pressing tab, insert 4 spaces
 set expandtab
"

" map enter to give a new line
nmap <CR> o<Esc>0"_D

let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction

function! SuggestOneWord()
    let suggestion = copilot#Accept("")
    let bar = copilot#TextQueuedForInsertion()
    return split(bar, '[ .]\zs')[0]
endfunction

imap <script><expr> <C-w> SuggestOneWord()

" OSCYank
vnoremap <leader>y :OSCYank<CR>
