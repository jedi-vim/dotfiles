" PLugins
call plug#begin()
Plug 'morhetz/gruvbox' 
Plug 'sainnhe/gruvbox-material'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/nerd-fonts'
Plug 'ryanoasis/vim-devicons'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'preservim/NERDTree'
Plug 'preservim/tagbar'
Plug 't9md/vim-choosewin'
Plug 'preservim/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-surround' 
Plug 'tpope/vim-repeat' 
Plug 'tommcdo/vim-exchange'
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
call plug#end()
" PLugins End
"
set number relativenumber
set autoindent
set incsearch
set wildmenu
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
set confirm
set title
set cursorline
set ignorecase
set updatetime=100
set hidden
setlocal scrolloff=9999
filetype plugin on

" Indentation default
set expandtab
set shiftwidth=4
set softtabstop=4

" Colo Scheme 
colorscheme gruvbox-material
syntax on
let g:gruvbox_contrast_dark='soft'
set termguicolors

" Comandos basicos
let mapleader = ","
" Salvar buffer
map <C-s> :w<CR>

autocmd VimEnter * source ~/.session.vim
autocmd VimLeave * mksession! ~/.session.vim

augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  hi CursorLine term=bold cterm=bold guibg=Grey30
  au WinLeave * setlocal nocursorline
augroup END

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" ChooseWin
nmap <leader>cw <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" Edit init.vim
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<cr>
" Reload vim conf
nnoremap <leader>sv :source ~/.config/nvim/init.vim<cr>

" AirLine
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_theme='base16'
let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'y']
      \ ]

" Hlsearch
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" GITGUTTER
" Stagear mudanças e desfaze-las (GIT)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
" Navegar por alterações (GIT)
nmap ]g <Plug>(GitGutterNextHunk)
nmap [g <Plug>(GitGutterPrevHunk)

" Toogle Git Blame
map <F7> :G blame<cr>

" Toogle TagBar
nmap <F8> :TagbarToggle<CR>

"Toogle do NerdTree
map <F9> :NERDTreeToggle<CR>
let NERDTreeIgnore=[ '\.git$', '\.pyc$', '\.egg-info$', '__pycache__', 'CodeAnalysis', 'out']
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Copiar para o clip board
vmap yy "+y

" Fzv.vim
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>g :Ag<CR>
nnoremap <silent> <leader>h :History<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>bt :BTags<CR>
nnoremap <silent> <leader>bc :GBranches<CR>
" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules --exclude=django_cache exclude=static'
" Excluindo diretorios que naturalmente nao precisam ser indexados
" let $FZF_DEFAULT_COMMAND =  \"find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'dist/**' -prune -o  -type f -print -o -type l -print 2> /dev/null"
let $FZF_DEFAULT_COMMAND="git ls-files --cached --others --exclude-standard || fd --type f --type l --hidden --follow"
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" COC-VIM 
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

"""" Ação sobre o cursor
nmap <silent> <c-space> :CocAction<CR>

"""" Navegar por erros e warnings
vmap <Tab> <Plug>(coc-snippets-select)
nmap <silent> [w <Plug>(coc-diagnostic-prev)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)

"""" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Use <c-space> to trigger completion.
inoremap <silent><expr> <tab> coc#refresh()
"""" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
"""" Apply AutoFix to problem on the current line.
nmap <silent> gf  <Plug>(coc-fix-current)
"""" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

let g:coc_global_extensions=[
            \'coc-docker' ,
            \'coc-highlight',
            \'coc-yaml',
            \'coc-pyright',
            \'coc-eslint'
            \]

" Desfaz selecao apos busca
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

" Busca fuzzy
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)
map zg/ <Plug>(incsearch-fuzzy-stay)

"Atalho para mover blocos de texto
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Mudar para proxima janela
map <Tab> <C-W>w

" Navegação entre buffers
nnoremap  <C-Right> :bn<CR>
nmap  <C-Left> :bp<CR>
nmap  <leader>q :bd<CR>

" Resize da janelas
" Vertical
nnoremap <C-w>- <C-w>5-_
nnoremap <C-w>= <C-w>5+
" Horizontal
nnoremap <C-w>, <C-w>5<
nnoremap <C-w>. <C-w>5>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz
