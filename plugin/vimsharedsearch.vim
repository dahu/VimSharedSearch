" ============================================================================
" File:        vimsharedsearch.vim
" Version:     0.0.3
" Modified:    2 February, 2011
" Description: Share most recent search across Vim instances.
" Maintainer:  Barry Arthur <barry dot arthur at gmail dot com>
" Website:     http://github.com/dahu/VimSharedSearch
"
" Licensed under the same terms as Vim itself.
" ============================================================================
let s:VimSharedSearch_version = '0.0.3'  " Fixed [nN] search directions (local to session)

" allow user to prevent loading
" and prevent duplicate loading
if exists("loaded_vimsharedsearch") || &cp
  finish
endif
let loaded_vimsharedsearch = 1

function! LoadSearch()
  let dir = v:searchforward
  let search_history = readfile("/tmp/vim_search_history")
  call histadd("search", search_history[0])
  let @/ = histget("search")
  return dir
endfunction

let s:last_search = ''
function! SaveSearch()
  let search_history = histget("search")
  if search_history != s:last_search
    let s:last_search = search_history
    call writefile([search_history], "/tmp/vim_search_history")
  endif
endfunction

nnoremap * *:call SaveSearch()<CR>:echo @/<CR>
nnoremap # #:call SaveSearch()<CR>:echo @/<CR>
nnoremap n :let v:searchforward = LoadSearch()<CR>n
nnoremap N :let v:searchforward = LoadSearch()<CR>N

augroup VimSharedSearch
  au!
  au CursorMoved * call SaveSearch()
augroup END

" vim: set sw=2 sts=2 et fdm=marker:
