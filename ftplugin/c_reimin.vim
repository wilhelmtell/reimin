if exists("b:loaded_ftplugin_reimin")
  finish
endif
let b:loaded_ftplugin_reimin = 1

" let b:reiminSystemInclude = {'keyword': '#include', 'delimiter': ' ', 'substitute': [['^', '<', ''], ['$', '>', '']], 'prompt': 'System Include: '}
let b:reiminLocalInclude = {'keyword': '#include', 'delimiter': ' ', 'substitute': [['^', '"', ''], ['$', '"', '']], 'prompt': 'Local Include: '}

let b:undo_ftplugin = "unlet b:reiminSystemInclude "
      \ . "| unlet b:reiminLocalInclude "
      \ . "| unlet b:loaded_ftplugin_reimin "
