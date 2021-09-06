syntax on
set background=dark

filetype off
call plug#begin()

Plug 'jiangmiao/auto-pairs'
Plug 'flazz/vim-colorschemes'
Plug 'sickill/vim-monokai'
Plug 'tpope/vim-surround'
Plug 'justinmk/vim-sneak'
Plug 'tomtom/tcomment_vim'
Plug 'alvan/vim-closetag'
Plug 'pantharshit00/vim-prisma'

"autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" beautify plug
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"highlight
Plug 'sheerun/vim-polyglot'
Plug 'frazrepo/vim-rainbow'
Plug 'HerringtonDarkholme/yats.vim'

call plug#end()

filetype plugin indent on

colorscheme monokai

highlight Pmenu ctermbg=238 gui=bold
" hi Normal guibg=NONE ctermbg=NONE
" airline setting {
let g:airline_theme="deus"
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep='|'
let g:rainbow_active=1
" }

set bsdir=buffer
set t_Co=256
set hidden
set laststatus=2
set fencs=utf-8,gb2312,gbk,gb18030

set number
set nobackup
set nowritebackup
set mouse=a
set relativenumber
set backspace=2
set backspace=indent,eol,start
set ic
set expandtab
set noswapfile
set softtabstop=2
set autoindent shiftwidth=2
set smartindent shiftwidth=2
set foldmethod=indent
set foldlevelstart=99
set pastetoggle=<F12>
set clipboard+=unnamedplus
set signcolumn=yes
set cmdheight=3

let mapleader=","
let g:mapleader=","

" hi Normal guibg=NONE ctermbg=NONE

let g:coc_global_extensions = ['coc-json', 'coc-explorer', 'coc-git', 'coc-lists']

"autoclose Tag {
let g:closetag_filenames = '*.html,*.html.erb, *.vue, *tsx, *jsx'
let g:closetag_emptyTags_caseSensitive = 1
let g:closetag_shortcut = '>'
let g:closetag_close_shortcut ='<leader>>'
"}

" vim config 
let g:vue_pre_processors = ['pug']
"
if has("conceal")
  set conceallevel=2 concealcursor=nv
endif

"Key Mapping {
inoremap jk <Esc>
inoremap <C-j> <Esc>o
inoremap <C-k> <Esc>O
nnoremap <M-l> mzgg=G`z

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <s-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


" Diagnostic
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>f  <Plug>(coc-format)
xmap <leader>f  <Plug>(coc-format-selected)

nnoremap <silent> K :call <SID>show_documentation()<CR>


tmap <Esc> <C-\><C-n>
nnoremap <leader>` :belowright split term://$SHELL<CR>:set nonumber norelativenumber<CR>i
nnoremap <leader><leader>` :belowright vsplit term://$SHELL<CR>:set nonumber norelativenumber<CR>i

"AutoCMD {
autocmd CursorHold * silent call CocActionAsync('highlight')
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd FileType * autocmd BufWritePre * silent call CocAction('format')
"}


"Functions {
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"}

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap`
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support,
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin,
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
nnoremap <silent> <space>g :<C-u>CocList grep<CR>
nnoremap <silent> <space>l :<C-u>CocList lines<CR>
nnoremap <silent> <space>f :<C-u>CocList files<CR>

"       " Resume latest coc list
nnoremap <silent> <C-p>  :<C-u>CocListResume<CR>"
nnoremap <silent> <C-j>  :<C-u>CocNext<CR>
nnoremap <silent> <C-k>  :<C-u>CocPrev<CR>
nnoremap <silent> <C-e> :CocCommand explorer<CR>

