"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" reimin - easily #include a header
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("loaded_reimin")
  finish
endif
if v:version < 700
  echoerr "reimin: this plugin requires vim >= 7."
  finish
endif
let loaded_reimin = 1

function! s:reiminIncludeSystem()
endfunction

function! s:prompt()
  if &ft == "cpp" || &ft == "c"
    return "#include"
  else
    return -1
  endif
endfunction

function s:reiminMain()
  let l:prompt = s:prompt()
  if l:prompt == -1
    return
  endif
  let l:header = input(l:prompt . " ")
  let l:header = substitute(l:header, "^\\s\\+\\|\\s\\+$", "", "g")
  let l:pos = search(l:prompt, "bnw") " FIXME: regex-escape l:prompt
  if( l:header != "" )
    call append(l:pos, prompt . " <" . l:header . ">")
  endif
endfunction
command Include :call s:reiminMain()
