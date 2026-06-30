if exists("b:current_syntax") | finish | endif

" types in signatures
syn keyword lctrsType Int Bool result err ret

" boolean literals
syn keyword lctrsBool true false

" $-prefixed fresh variables
syn match lctrsVar /\$\w\+/

" integer literals (incl. negative)
syn match lctrsNumber /-\?\d\+/

" logic / arithmetic / relational operators (unicode + ascii)
syn match lctrsOp /[∧∨¬≥≤≠=<>+*/%-]/
syn match lctrsOp /->/
syn match lctrsOp /::/

" the rule guard separator
syn match lctrsGuard /|/

" a symbol applied like a function: name(  -> treat name as a function
syn match lctrsFunc /\<\h\w*\ze\s*(/

" any other bare identifier (not followed by '(') is a variable: a, b, x, y
syn match lctrsVar /\<\h\w*\>\(\s*(\)\@!/

hi def link lctrsType    Type
hi def link lctrsVar     Identifier
hi def link lctrsNumber  Number
hi def link lctrsBool    Constant
hi def link lctrsOp      Operator
hi def link lctrsGuard   Delimiter
hi def link lctrsFunc    Function

let b:current_syntax = "lctrs"
