#Pascal Grammar
**[xxx]**   represents a non-terminal     => write a procedure
**xxx**     represents a terminal symbol  => match the terminal
[prog] 			        ::= 	[prog header] [var part] [stat part]
--------------------------------------------------------------------------------------------------------
[prog header] 		  ::= 	program id ( input , output ) ;
--------------------------------------------------------------------------------------------------------
[var part] 		      ::= 	var [var dec list]
[var dec list] ¤ 	  ::= 	[var dec] | [var dec list] [var dec]
[var dec] 		      ::= 	[id list] : [type] ;
[id list] ¤ 		    ::= 	id | [id list] , id
[type] 			        ::= 	integer | real | boolean
--------------------------------------------------------------------------------------------------------
[stat part] 		    ::= 	begin [stat list] end .
[stat list] ¤ 		  ::= 	[stat] | [stat list] ; [stat]
[stat] 			        ::= 	[assign stat]
[assign stat] 		  ::= 	id := [expr]
[expr] ¤ 		        ::= 	[term] | [expr] + [term]
[term] ¤ 		        ::= 	[factor] | [term] * [factor]
[factor] 		        ::= 	( [expr] ) | [operand]
[operand] 		      ::= 	id | number
--------------------------------------------------------------------------------------------------------
¤ - left recursive definitions! See Parser Hints for further information and help.
--------------------------------------------------------------------------------------------------------
Extended BNF (EBNF) definitions (* = zero or more occurrences)
[var dec list] 		  ::= 	[var dec]     { [var dec] } *
[id list] 		      ::= 	id                 { , id } *
[stat list] 		    ::= 	[stat]           { ; [stat] } *
[expr] 			        ::= 	[term]         { + [term] } *
[term] 			        ::= 	[factor]       { * [factor] } *
--------------------------------------------------------------------------------------------------------
==> void var_dec_list() { var_dec(); if (lookahead == id) var_dec_list(); }
==> void id_list() { match(id); if (lookahead == ',') { match(','); id_list(); } }
==> void stat_list() { stat(); if (lookahead == ';') { match(';'); stat_list(); } }
