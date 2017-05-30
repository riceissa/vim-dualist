if exists("g:loaded_dualist") || &cp
  finish
endif
let g:loaded_dualist = 1

" Check from
" <https://github.com/tpope/vim-sensible/commit/38fea1c9356d46cc285f67c9f8e7bc3ba39fc0be>
let s:use_unicode = !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')

function! s:ResetInsertEnter() abort
  if s:use_unicode
    let &listchars = "tab:\u25b8 ,nbsp:\u2423"
  else
    let &listchars = "tab:> ,nbsp:+"
  endif
endfunction

function! s:ResetInsertLeave() abort
  if s:use_unicode
    let &listchars = "tab:\u25b8 ,trail:\u00b7,nbsp:\u2423"
  else
    let &listchars = "tab:> ,trail:-,nbsp:+"
  endif
endfunction

function! s:ColorListchars() abort
  if &t_Co >= 16
    " Changing ctermbg is useful for seeing tab with :set list
    if &background ==# "dark"
      highlight SpecialKey ctermfg=LightGray ctermbg=DarkGray
      if has('nvim')
        highlight Whitespace ctermfg=LightGray ctermbg=DarkGray
      endif
    else
      highlight SpecialKey ctermfg=DarkGray ctermbg=LightGray
      if has('nvim')
        highlight Whitespace ctermfg=DarkGray ctermbg=LightGray
      endif
    endif
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

    if exists('##OptionSet') && exists("g:dualist_color_listchars") && g:dualist_color_listchars == 1
      autocmd OptionSet background call <SID>ColorListchars()
    endif
  augroup END
endif

set list
call <SID>ResetInsertLeave()
if exists("g:dualist_color_listchars") && g:dualist_color_listchars == 1
  call <SID>ColorListchars()
endif
