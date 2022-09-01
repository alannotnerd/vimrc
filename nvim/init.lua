require("core.bootstrap")

require("core.options").setup()
require("core.keymaps").setup()
require("core.plugin_loader").setup({
  "navarasu/onedark.nvim",
  "tanvirtin/monokai.nvim",
  { "rose-pine/neovim", as = "rose-pine" },
  {
    "neoclide/coc.nvim",
    branch = 'release',
    config = function ()
      vim.cmd([[
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        autocmd CursorHold * silent call CocActionAsync('highlight')
        autocmd FileType * autocmd BufWritePre * silent call CocAction('format')

        inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
        inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"

        inoremap <silent><expr> <C-c> coc#pum#visible() ? coc#pum#cancel() : "\<C-c>"
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


        " Diagnostic
        nmap <silent> [g <Plug>(coc-diagnostic-prev)
        nmap <silent> ]g <Plug>(coc-diagnostic-next)

        " Remap keys for gotos
        nmap <silent> gd <Plug>(coc-definition)
        nmap <silent> gr <Plug>(coc-references)
        nmap <leader>rn <Plug>(coc-rename)
        nmap <leader>f  <Plug>(coc-format)
        xmap <leader>f  <Plug>(coc-format-selected)

        " Fix autofix problem of current line
        nnoremap <leader>qf  <Plug>(coc-fix-current)
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        nnoremap <silent> <space>g :<C-u>CocList grep<CR>
        nnoremap <silent> <space>l :<C-u>CocList lines<CR>
        nnoremap <silent> <space>f :<C-u>CocList files<CR>

        nnoremap <silent> <C-p>  :<C-u>CocListResume<CR>"
        nnoremap <silent> <C-j>  :<C-u>CocNext<CR>
        nnoremap <silent> <C-k>  :<C-u>CocPrev<CR>
        let g:coc_global_extensions = ['coc-json', 'coc-lists', 'coc-tsserver', 'coc-rust-analyzer']
      ]])
    end
  }
})
require("core.logger"):setup({ name = "aim", level = "DEBUG" })

require("core.explorer").setup()
require("core.ui").setup({
  colorscheme = "onedark"
})

vim.cmd([[hi def link CocMenuSel PmenuSel]])
