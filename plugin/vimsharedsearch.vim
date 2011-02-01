" ============================================================================
" File:        vimsharedsearch.vim
" Version:     0.0.2
" Modified:    1 February, 2011
" Description: Share most recent search across Vim instances.
" Maintainer:  Barry Arthur <barry dot arthur at gmail dot com>
" Website:     http://github.com/dahu/VimSharedSearch
"
" Licensed under the same terms as Vim itself.
" ============================================================================
let s:VimSharedSearch_version = '0.0.2'  " minor bugfixes for first release

" Allow users to disable ftplugins
if exists('no_plugin_maps') || exists('no_vim_maps')
  " User doesn't want this functionality.
  finish
endif

function! LoadSearch()
  let search_history = readfile("/tmp/vim_search_history")
  call histadd("/", search_history[0])
  let @/ = histget("/", -1)
endfunction

let s:last_search = ''
function! SaveSearch()
  let search_history = histget("/", -1)
  if search_history != s:last_search
    let s:last_search = search_history
    call writefile([search_history], "/tmp/vim_search_history")
  endif
endfunction

nnoremap / :silent call LoadSearch()<CR>/
nnoremap ? :silent call LoadSearch()<CR>?
nnoremap * *:silent call SaveSearch()<CR>:echo @/<CR>
nnoremap # #:silent call SaveSearch()<CR>:echo @/<CR>
nnoremap n :silent call LoadSearch()<CR>n
nnoremap N :silent call LoadSearch()<CR>N

augroup VimSharedSearch
  au!
  au CursorMoved * call SaveSearch()
augroup END

" vim: set sw=2 sts=2 et fdm=marker:
