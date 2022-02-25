call plug#begin('~/.config/nvim/plugged')
" ----------Plugins from https://habr.com/ru/post/486948/ ----------
" FuzzyFinder (для быстрого поиска)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" NERDTree - быстрый просмотр файлов
Plug 'preservim/nerdtree'
" Сoc - автодополнение 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Дополнения для NERDTree
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'preservim/nerdcommenter'
" Дополнение для Git, а также иконки для NERDTree
Plug 'airblade/vim-gitgutter'
Plug 'ryanoasis/vim-devicons'
" Линия статуса
Plug 'itchyny/lightline.vim'
" Проверка Синтаксиса
Plug 'scrooloose/syntastic' 
" -----------------------------------------------------------------
Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
"let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'
let g:pandoc#syntax#conceal#use=1
hi Conceal ctermbg=none
" Themes
Plug 'dylanaraps/wal.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'cocopon/iceberg.vim'
call plug#end()

" Matlab
source $VIMRUNTIME/macros/matchit.vim
au FileType matlab set foldmethod=syntax foldcolumn=2 foldlevel=33

" let loaded_matchit = 1

set clipboard=unnamedplus
set nocompatible
set mouse=a
syntax on
set number
set relativenumber
set ruler
filetype plugin indent on

source $HOME/.config/nvim/plug-config/coc.vim

" Комбинация клавиш jkl - действует как Escape в режиме Insert
inoremap jkl <ESC>

" Делаем так, чтобы навигация работала на русском языке
nmap о j
nmap л k
nmap р h
nmap д l
nmap ш i
nmap ф a
nmap в d

" В нормальном режиме Ctrl+n вызывает :NERDTree
nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggl

let g:NERDTreeGitStatusWithFlags = 1
let g:NERDTreeIgnore = ['^node_modules$']

colorscheme wal 

" Линия статуса: конфигурация
set noshowmode " Табличка --INSERT-- больше не выводится на экран
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

let g:no_highlight_group_for_current_word=["Statement", "Comment", "Type", "PreProc"]
function s:HighlightWordUnderCursor()
    let l:syntaxgroup = synIDattr(synIDtrans(synID(line("."), stridx(getline("."), expand('<cword>')) + 1, 1)), "name")

    if (index(g:no_highlight_group_for_current_word, l:syntaxgroup) == -1)
        exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
    else
        exe 'match IncSearch /\V\<\>/'
    endif
endfunction

autocmd CursorMoved * call s:HighlightWordUnderCursor()
