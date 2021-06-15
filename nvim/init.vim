"#######################

"#######################

" Leader remap
nnoremap <space> <NOP>
let mapleader = " "

"#######################
"######  Plugins  ######
"#######################

call plug#begin(stdpath('data') . '/plugged')

Plug 'neoclide/coc.nvim', { 'branch': 'release'}
Plug 'knubie/vim-kitty-navigator'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'machakann/vim-sandwich'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdcommenter'
Plug 'bkad/CamelCaseMotion'
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'        
Plug 'tpope/vim-eunuch'
Plug 'sbdchd/neoformat'
Plug 'alvan/vim-closetag'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'arthurxavierx/vim-caser'
" Themes
Plug 'sts10/vim-pink-moon'

call plug#end()

"#######################
"###  Plugin Config  ###
"#######################

"#################
"# Code completion
"#################

" CocConfig

let g:coc_global_extensions = ['coc-css', 'coc-cssmodules', 'coc-eslint', 'coc-explorer', 'coc-json', 'coc-prettier', 'coc-tsserver', 'coc-snippets', 'coc-pyright']

call coc#config("eslint.autoFixOnSave", v:true)
call coc#config("typescript.showUnused", v:false)
call coc#config("coc.preferences", { 
	\ "formatOnSaveFiletypes": [
	\ 	"css", 
	\	"js", 
	\	"javascriptreact", 
	\	"ts", 
	\	"typescriptreact", 
	\	"html", 
	\	"scss", 
	\	"sass",
	\	"c"
\]})
call coc#config("languageserver", {
	\ "ccls": {
	\	"command": "ccls",
	\	"filetypes": ["c", "cpp", "cuda", "objc", "objcpp"],
	\	"rootPatterns": [".ccls-root", "compile_commands.json"],
	\	"initializationOptions": {
	\		"cache": {
	\			"directory": ".ccls-cache"
	\		},
	\		"client": {
	\			"snippetSupport": v:true
	\		}
	\	}
	\}
\})

" Coc-Prettier config
"call coc#config("prettier", {
	"\ "eslintIntegration": v:true,
	"\ "tslintIntegration": v:true,
	"\ "stylelintIntegration": v:true
"\})
call coc#config("prettier", {
	\ "tabWidth": 4,
	\ "printWidth": 160
\})


" Coc-Explorer config
call coc#config("explorer.keyMappings.global", {
	\ "<cr>": ["wait", "expandable?", ["expanded?", "collapse", "expand"], "open"],
	\ "S": "open:vsplit",
	\ "[[": ["wait", "indentPrev"],
	\ "]]": ["wait", "indentNext"],
	\ "[{": ["wait", "sourcePrev"],
	\ "]}": ["wait", "sourceNext"]
\})

call coc#config("explorer.width", 30)
call coc#config("explorer.quitOnOpen", v:true)
call coc#config("explorer.icon.enableNerdfont", v:true)
call coc#config("explorer.icon.enableDevicons", v:true)
call coc#config("explorer.file.showHiddenFiles", v:true)

noremap <silent> <leader>o :CocCommand explorer<CR>

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <C-Space> coc#refresh()
nmap <leader>qf <Plug>(coc-fix-current)

"GoTo code navigation
nmap <leader>g <C-o>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ]e <Plug>(coc-diagnostic-next-error)
nmap <silent> [e <Plug>(coc-diagnostic-prev-error)
nmap <silent> ]w <Plug>(coc-diagnostic-next)
nmap <silent> [w <Plug>(coc-diagnostic-prev)

nmap <leader>rn <Plug>(coc-rename)

"Help on K
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else 
		call CocAction('doHover')
	endif
endfunction

"au CursorHoldI * sil call CocActionAsync('showSignatureHelp')

"show all diagnostics.
nnoremap <silent> <space>d :<C-u>CocList diagnostics<CR>
"manage extensions.
nnoremap <silent> <space>e :<C-u>CocList extensions<CR>

command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')
command! -nargs=0 Format :call CocAction('format')
nmap <silent> <leader>p :call CocAction('format')<CR>;

" # Coc-Prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile
"nmap <silent> <leader>p :CocCommand prettier.formatFile<CR>
vmap <leader>p <Plug>(coc-format-selected)


"#################
"# Kitty Navigator
"#################

let g:kitty_navigator_no_mappings = 1
nnoremap <silent> <C-h> :KittyNavigateLeft<CR>
nnoremap <silent> <C-j> :KittyNavigateDown<CR>
nnoremap <silent> <C-k> :KittyNavigateUp<CR>
nnoremap <silent> <C-l> :KittyNavigateRight<CR>

"#################
"# fzf
"#################

noremap <silent> <leader>; :Buffers<CR>
noremap <silent> <leader>f :Files<CR>
noremap <silent> <leader>h :History<CR>
noremap <silent> <leader>t :Ag<CR>

"#################
"# CamelCaseMotion
"#################

let g:camelcasemotion_key = '<leader>'

"#################
"# CloseTag
"#################

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.jsx,*.tsx'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.tsx'
let g:closetag_filetypes = 'html,xhtml,phtml,typescriptreact,javascriptreact'
let g:closetag_xhtml_filetypes = 'xhtml,javascriptreact,typescriptreact'
let g:closetag_emptyTags_caseSensitive = 1

let g:closetag_regions = {
\ 'typescriptreact': 'jsxRegion,tsxRegion',
\ 'javascriptreact': 'jsxRegion',
\ }

let g:closetag_shortcut = '>'
let g:closetag_close_shortcut = '@>'

"#################
"# Vim Multi
"#################

let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps["Add Cursor Down"] = '<C-M-j>'
let g:VM_maps["Add Cursor Up"] = '<C-M-k>'

"#######################
"###  Key Remappings  ##
"#######################

" Replace occurrances of word 
nnoremap <leader>c* *``cgn
nnoremap <leader>c# #``cgN

" Easier splits
nnoremap <silent> <leader><bar> :vsplit<CR>
nnoremap <silent> <leader>- :split<CR>
nnoremap <silent> <leader>q :close<CR>
nnoremap <silent> <F2> <C-w><C-o>

" Open explorer
"nnoremap <silent> <leader>o :Lex<CR>

" Cycle between buffers
nnoremap <silent> <tab> :b#<CR>
nnoremap <silent> <S-tab> :bnext<CR>

" Remap netrw refresh to allow ctrl l as split movement
" when netrw is open.
nmap <C-p> <Plug>NetrwRefresh

" Remove search highlighting on <F3>
nnoremap <silent> <F3> :noh<CR>

" Easier pane resizing
"nnoremap <silent> <Leader>+ :resize +10<CR>
"nnoremap <silent> <Leader>- :resize -10<CR>
nnoremap <silent> <Leader>> :vertical resize +10<CR>
nnoremap <silent> <Leader>< :vertical resize -10<CR>
nnoremap <leader>= <C-W>=

" fugitive
nnoremap <silent> <leader>gd :Gvdiff<CR>
nnoremap <silent> <leader>gh :diffget //2<CR>
nnoremap <silent> <leader>gl :diffget //3<CR>
nnoremap <silent> <leader>gs :G<CR>
nnoremap <silent> <leader>gm :Git commit<CR>
nnoremap <silent> <leader>gg :Gclog<CR>
nnoremap <silent> <leader>gpy :Git push<CR>
nnoremap  <leader>gc :Git checkout 

" Quick open adjacent file
nnoremap <leader>la :e <C-R>=expand('%:h')."/"<CR>

" Remap backtick for easier mark jumping
nnoremap ' `

" Remap to quick delete buffers
nnoremap <silent> <leader>c :bd<CR>

" Paste without overwriting buffer (safe paste).
xnoremap sp "_dP

"#######################
"##  Custom Commands  ##
"#######################

" Close all buffers but current
command! BufOnly silent! execute "%bd|e#|bd#"

"#######################
"####  Color Scheme  ###
"#######################

set termguicolors
syntax enable

colorscheme pink-moon

"#######################
"####  Status Line  ####
"#######################

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V-Line ',
       \ "\<C-V>" : 'V-Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'R ',
       \ 'Rv' : 'V-Replace ',
       \ 'c'  : 'Command ',
       \ 't'  : 'Terminal ',
       \}

set statusline=                                 " Clear
set statusline+=\ %{toupper(g:currentmode[mode()])}
set statusline+=%#PmenuSel#						" Color
set statusline+=%{StatuslineGit()}				" git status
set statusline+=%#LineNr#						" Color
set statusline+=\ %f                            " Filename
set statusline+=%h                              " Help file flag
set statusline+=%r                              " Read only flag
set statusline+=%m                              " Modified flag
set statusline+=%=                              " Left/right separator
set statusline+=\ \                             " --
set statusline+=%{&filetype}                    " Filetype
set statusline+=\ \                             " --
set statusline+=[%{&fenc}]                        " File encoding
set statusline+=[%{&ff}]                        " File format
set statusline+=[                               " Indent settings: begin
set statusline+=%{&expandtab?\"sp\":\"tab\"}\   " Indent settings
set statusline+=%{&shiftwidth}                  " Indent settings
set statusline+=]                               " Indent settings: end
set statusline+=\ \                             " --
set statusline+=[%l\,%02v]:%L                          " Cursor line/total lines

"#######################
"###  Relative Lines  ##
"#######################

set number relativenumber

:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

"#######################
"###  General Config  ##
"#######################

" Allow editing multiple unsaved buffers
set hidden

" Default fold method to syntax. Auto open all folds
set foldmethod=syntax
set foldlevelstart=20

" Tab config
set tabstop=4
set shiftwidth=4

" netrw directory setup
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20

" Set split open to right and below
set splitbelow
set splitright

" Set mouse scroll
set mouse=a

" Don't show mode as it's shown in the status bar
set noshowmode

" Dont show last command
set noshowcmd

" Set key command timeout
set timeoutlen=250
set ttimeoutlen=50

" Set spell checking
set spell spelllang=en

" Set custom title for kitty nav
set title
let &titlestring='%t - nvim'

" Update time
set updatetime=300

