# Pascal Grammar

**Non-terminal** symbols are written in square brackets (`[xxx]`),  
**Terminal** symbols are written in plain text (`xxx`).

---

## Grammar (BNF)

```bnf
<font color="blue">[prog]</font>           ::= <font color="blue">[prog header]</font> <font color="blue">[var part]</font> <font color="blue">[stat part]</font>

<font color="blue">[prog header]</font>    ::= program id "(" input "," output ")" ";"

<font color="blue">[var part]</font>       ::= var <font color="blue">[var dec list]</font>

<font color="blue">[var dec list]</font>   ::= <font color="blue">[var dec]</font>
                                           | <font color="blue">[var dec list]</font> <font color="blue">[var dec]</font>

<font color="blue">[var dec]</font>        ::= <font color="blue">[id list]</font> ":" <font color="blue">[type]</font> ";"

<font color="blue">[id list]</font>        ::= id
                                           | <font color="blue">[id list]</font> "," id

<font color="blue">[type]</font>           ::= <font color="red">integer</font>
                                           | <font color="red">real</font>
                                           | <font color="red">boolean</font>

<font color="blue">[stat part]</font>      ::= begin <font color="blue">[stat list]</font> end "."

<font color="blue">[stat list]</font>      ::= <font color="blue">[stat]</font>
                                           | <font color="blue">[stat list]</font> ";" <font color="blue">[stat]</font>

<font color="blue">[stat]</font>           ::= <font color="blue">[assign stat]</font>

<font color="blue">[assign stat]</font>    ::= id ":=" <font color="blue">[expr]</font>

<font color="blue">[expr]</font>           ::= <font color="blue">[term]</font>
                                           | <font color="blue">[expr]</font> "+" <font color="blue">[term]</font>

<font color="blue">[term]</font>           ::= <font color="blue">[factor]</font>
                                           | <font color="blue">[term]</font> "*" <font color="blue">[factor]</font>

<font color="blue">[factor]</font>         ::= "(" <font color="blue">[expr]</font> ")"
                                           | <font color="blue">[operand]</font>

<font color="blue">[operand]</font>        ::= id
                                           | number
