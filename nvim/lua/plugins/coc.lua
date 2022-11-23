local M = {
    "neoclide/coc.nvim",
    branch = 'release',
    config = function ()
      vim.cmd([[
        function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
        endfunction

        autocmd CursorHold * silent call CocActionAsync('highlight')
        #autocmd FileType * autocmd BufWritePre * silent call CocAction('format')

        inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#next(1) : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
        inoremap <silent><expr> <S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-p>"

        inoremap <silent><expr> <C-c> coc#pum#visible() ? coc#pum#cancel() : "\<C-c>"
        inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"


        " Remap keys for gotos
        nnoremap <silent> gd <Plug>(coc-definition)
        nnoremap <silent> gr <Plug>(coc-references)
        nnoremap <leader>rn <Plug>(coc-rename)
        nnoremap <leader>f  <Plug>(coc-format)
        xnoremap <leader>f  <Plug>(coc-format-selected)

        " Fix autofix problem of current line
        nnoremap <leader>qf  <Plug>(coc-fix-current)
        nnoremap <silent> <leader>ac <Plug>(coc-codeaction-cursor)
        nnoremap <silent> <space>sa  :<C-u>CocList -A diagnostics<cr>
        nnoremap <silent> <space>so  :<C-u>CocList -A outline<cr>
        nnoremap <silent> <space>ss  :<C-u>CocList -A -I symbols<cr>
        nnoremap <silent> <space>sg :<C-u>CocList -I -A grep<CR>
        nnoremap <silent> <space>sl :<C-u>CocList -I -A lines<CR>
        nnoremap <silent> <space>sf :<C-u>CocList -A files<CR>

        nnoremap <silent> <C-p>  :<C-u>CocListResume<CR>"
        nnoremap <silent> <C-j>  :<C-u>CocNext<CR>
        nnoremap <silent> <C-k>  :<C-u>CocPrev<CR>
        let g:coc_global_extensions = ['coc-json', 'coc-lists', 'coc-tsserver', 'coc-rust-analyzer']
      ]])
    end
  }

  return M
