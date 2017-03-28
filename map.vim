" :source map.vim
nnoremap <silent> ;r :w<CR>:echom system('../run.sh ' . expand('%'))<CR>:silent e<CR>
