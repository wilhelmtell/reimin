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

if has("autocmd")
  augroup reimin
    autocmd!
    autocmd FileType c,cpp   call s:InitC()
    autocmd FileType ruby    call s:InitRuby()
    autocmd FileType python  call s:InitPython()
  augroup END
endif

function! s:InitC()
  let s:include_params = {
  \   'keyword': '#include',
  \   'delimiter': ' ',
  \   'substitute': [
  \     ['^<\(.*\)>$', '<\1>', ''],
  \     ['^<\(.*[^>]\)$', '<\1>', ''],
  \     ['^[<"][>"]\?$', '', ''],
  \     ['^\(".*"\)$', '\1', ''],
  \     ['^"\(.*[^"]\)$', '"\1"', ''],
  \     ['^\([^<"]\)\(.*\)', '"\1\2"', '']
  \   ],
  \   'prompt': 'Include: '
  \ }
endfunction

function! s:InitRuby()
  let s:include_params = {
  \   'keyword': 'require',
  \   'delimiter': ' ',
  \   'substitute': [
  \     ['^', "'", ''],
  \     ['$', "'", '']
  \   ],
  \   'prompt': 'Require: '
  \ }
endfunction

function! s:InitPython()
  let s:include_params = {
  \   'keyword': 'import',
  \   'delimiter': ' ',
  \   'substitute': [],
  \   'prompt': 'Import: '
  \ }
endfunction

function! s:LStrip(str)
  return substitute(a:str, '^\s\+', "", "")
endfunction

function! s:RStrip(str)
  return substitute(a:str, '\s\+$', "", "")
endfunction

function! s:Strip(str)
  return s:RStrip(s:LStrip(a:str))
endfunction

function <SID>reiminMain(opts, args)
  let l:include = empty(a:args)
                \ ? s:Strip(input(a:opts['prompt'], '', 'file'))
                \ : a:args[0]
  let l:pos = search(a:opts['keyword'], "bnw") " FIXME: regex-escape l:prompt
  for pipe in a:opts['substitute']
    let l:include = substitute(l:include, pipe[0], pipe[1], pipe[2])
  endfor
  if ! empty(l:include)
    let l:include = a:opts['keyword'] . a:opts['delimiter'] . l:include
    call append(l:pos, l:include)
  endif
endfunction

command -nargs=? -complete=file Include :call <SID>reiminMain(s:include_params, split(<q-args>, '\s\+'))
