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

function s:reimin()
  let l:header = input("Include: ")
  if( l:header != "" )
    call append(0, "#include <" . l:header . ">")
  endif
endfunction
command Include :call s:reimin()
