" ============================================================================
" File:        vimsharedsearch.vim
" Description: Share most recent search across Vim instances.
" Author:      Barry Arthur <barry dot arthur at gmail dot com>
" Last Change: 1 February, 2011
" Website:     http://github.com/dahu/VimSharedSearch
"
" Licensed under the same terms as Vim itself.
" ============================================================================
let s:VimSharedSearch_version = '0.0.1'  " first release

function! LoadSearch()
  let search_history = readfile("/tmp/vim_search_history")
  call histadd("/", search_history[0])
  let @/ = histget("/", -1)
endfunction

function! SaveSearch()
  let search_history = histget("/", -1)
  call writefile([search_history], "/tmp/vim_search_history")
endfunction

nnoremap / :call LoadSearch()<CR>/
nnoremap ? :call LoadSearch()<CR>?
nnoremap * *:call SaveSearch()<CR>
nnoremap # #:call SaveSearch()<CR>
nnoremap n :call LoadSearch()<CR>n
nnoremap N :call LoadSearch()<CR>N
cnoremap <CR> <CR>:call SaveSearch()<CR>

" vim: set sw=2 sts=2 et fdm=marker:
