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

function <SID>reiminMain(opts)
  let l:include = input(a:opts['prompt'])
  let l:include = substitute(l:include, "^\\s\\+\\|\\s\\+$", "", "g")
  let l:pos = search(a:opts['keyword'], "bnw") " FIXME: regex-escape l:prompt
  if( l:include != "" )
    for pipe in a:opts['substitute']
      let l:include = substitute(l:include, pipe[0], pipe[1], pipe[2])
    endfor
    let l:include = a:opts['keyword'] . a:opts['delimiter'] . l:include
    call append(l:pos, l:include)
  endif
endfunction

" FIXME: have these commands defined only for relevant &ft
command IncludeSystem :call <SID>reiminMain(b:reiminSystemInclude)
command IncludeLocal :call <SID>reiminMain(b:reiminLocalInclude)
