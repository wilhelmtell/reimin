if exists("b:loaded_ftplugin_reimin")
  finish
endif
let b:loaded_ftplugin_reimin = 1

function! <SID>reiminSystemInclude()
  return {'keyword': '#include', 'delimiter': ' ', 'substitute': [['^', '<', ''], ['$', '>', '']], 'prompt': 'System Include: '}
endfunction

function! <SID>reiminLocalInclude()
  return {'keyword': '#include', 'delimiter': ' ', 'substitute': [['^', '"', ''], ['$', '"', '']], 'prompt': 'Local Include: '}
endfunction

let b:undo_ftplugin = "delfunction b:reiminSystemInclude "
      \ . "| delfunction b:reiminLocalInclude "
      \ . "| unlet b:loaded_ftplugin_reimin "
