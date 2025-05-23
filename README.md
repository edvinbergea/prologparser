# Pascal Grammar

**Non-terminal** symbols are written in square brackets (`[xxx]`),  
**Terminal** symbols are written in plain text (`xxx`).

---

## Grammar (BNF)

```bnf
[prog]           ::= [prog header] [var part] [stat part]

[prog header]    ::= program id "(" input "," output ")" ";"

[var part]       ::= var [var dec list]

[var dec list]   ::= [var dec]
                   | [var dec list] [var dec]

[var dec]        ::= [id list] ":" [type] ";"

[id list]        ::= id
                   | [id list] "," id

[type]           ::= integer
                   | real
                   | boolean

[stat part]      ::= begin [stat list] end "."

[stat list]      ::= [stat]
                   | [stat list] ";" [stat]

[stat]           ::= [assign stat]

[assign stat]    ::= id ":=" [expr]

[expr]           ::= [term]
                   | [expr] "+" [term]

[term]           ::= [factor]
                   | [term] "*" [factor]

[factor]         ::= "(" [expr] ")"
                   | [operand]

[operand]        ::= id
                   | number
