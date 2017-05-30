if exists("g:loaded_dualist") || &cp
  finish
endif
let g:loaded_dualist = 1

" Check from
" <https://github.com/tpope/vim-sensible/commit/38fea1c9356d46cc285f67c9f8e7bc3ba39fc0be>
let s:use_unicode = !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')

function! s:ResetInsertEnter()
  if s:use_unicode
    let &listchars = "tab:\u25b8 ,nbsp:\u2423"
  else
    let &listchars = "tab:> ,nbsp:+"
  endif
endfunction

function! s:ResetInsertLeave()
  if s:use_unicode
    let &listchars = "tab:\u25b8 ,trail:\u00b7,nbsp:\u2423"
  else
    let &listchars = "tab:> ,trail:-,nbsp:+"
  endif
endfunction

if has('autocmd')
  augroup dualist
    autocmd!
    " This is a hack so that nbsp doesn't disappear in insert mode. For some
    " reason with the autocommands below, Vim requires there to be *some*
    " syntax matching in the buffer in order for nbsp to not disappear. The
    " match can be any character.
    autocmd VimEnter,BufNewFile,BufRead * syn match dualistNbsp "+"

    autocmd InsertEnter * call <SID>ResetInsertEnter()
    autocmd InsertLeave * call <SID>ResetInsertLeave()
  augroup END
endif

set list
call <SID>ResetInsertLeave()
