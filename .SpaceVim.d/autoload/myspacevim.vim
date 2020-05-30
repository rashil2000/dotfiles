function! myspacevim#before() abort
  map i <Up>
  map j <Left>
  map k <Down>
  noremap h i
endfunction

function! myspacevim#after() abort
  highlight Comment cterm=italic
endfunction
