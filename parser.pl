/******************************************************************************/
/* Prolog Lab 3                                                               */
/******************************************************************************/

:- [cmreader].

/******************************************************************************/
/* labels for the token values                                                */
/******************************************************************************/

program  -->   [256].
id       -->   [270].
lp       -->   [40].
input    -->   [257].
output   -->   [258].
rp       -->   [41].
scolon   -->   [59].
var      -->   [259].
colon    -->   [58].
comma    -->   [44].
int      -->   [260].
real     -->   [264].
bool     -->   [263].
begin    -->   [261].
end      -->   [262].
dot      -->   [46].
assign   -->   [271].
add      -->   [43].
mult     -->   [42].
num      -->   [272].

/******************************************************************************/
/* labels for the token values                                                */
/******************************************************************************/

lexer([], []).
lexer([L1|Ls], [T1|Ts]) :-
   lookup_tok(L1, T1),
   lexer(Ls, Ts).

tok_map([
   'program'  -    256,
   '('        -    40,
   'input'    -    257,
   'output'   -    258,
   ')'        -    41,
   ';'        -    59,
   'var'      -    259,
   ':'        -    58,
   ','        -    44,
   'integer'  -    260,
   'real'     -    264,
   'boolean'  -    263,
   'begin'    -    261,
   'end'      -    262,
   '.'        -    46,
   ':='       -    271,
   '+'        -    43,
   '*'        -    42    
]).

lookup_tok(Lex, Tok) :-
  tok_map(Map),
  memberchk(Lex-Tok, Map), !.

lookup_tok(Lex, 272) :-
   atom_chars(Lex, Clist),
   Clist \= [],
   maplist(char_type_digit, Clist), !.

lookup_tok(Lex, 270) :-
   atom_chars(Lex, [H|T]),
   char_type(H, alpha),
   maplist(char_type_alnum, T), !.

lookup_tok(Lex, 275) :-
   Lex = -1, !.

lookup_tok(_, 273) :-
   true.

char_type_digit(C) :- char_type(C, digit).
char_type_alnum(C) :- char_type(C, alnum).


/******************************************************************************/
/* Grammar Rules in Definite Clause Grammar form                              */
/******************************************************************************/

program_grmr       --> 		prog_head_grmr, var_part_grmr, stat_part_grmr.

/******************************************************************************/
/* Program Header                                                             */
/******************************************************************************/
prog_head_grmr     --> 		program, id, lp, input, comma, output, rp, scolon.

/******************************************************************************/
/* Var_part                                                                   */
/******************************************************************************/
var_part_grmr    	--> 	   var, var_dec_list_grmr.
var_dec_list_grmr -->      var_dec_grmr, var_dec_list_rest.
var_dec_list_rest -->      [].
var_dec_list_rest -->      var_dec_grmr, var_dec_list_rest.
var_dec_grmr 		-->		id_list_grmr, colon, type_grmr, scolon.
id_list_grmr      -->      id, id_list_rest.
id_list_rest      -->      [].
id_list_rest      -->      comma, id, id_list_rest.
type_grmr 			-->		int ; real ; bool.

/******************************************************************************/
/* Stat part                                                                  */
/******************************************************************************/
stat_part_grmr   	-->   	begin, stat_list_grmr, end, dot.
stat_list_grmr    -->      stat_grmr, stat_list_rest.
stat_list_rest    -->      [].
stat_list_rest    -->      scolon, stat_grmr, stat_list_rest.
stat_grmr 			-->		assign_stat_grmr.
assign_stat_grmr 	-->		id, assign, expr_grmr.
expr_grmr         -->      term_grmr, expr_rest.
expr_rest         -->      [].
expr_rest         -->      add, term_grmr, expr_rest.
term_grmr         -->      factor_grmr, term_rest.
term_rest         -->      [].
term_rest         -->      mult, factor_grmr, term_rest.
factor_grmr			--> 	   lp, expr_grmr, rp ; operand_grmr.
operand_grmr 		-->		id ; num.

/******************************************************************************/
/* Parser                                                                     */
/******************************************************************************/

parser(Ts, R) :-
   (program_grmr(Ts, [])
      -> R = 'Parse OK!'
      ;  R = 'Parse Fail!'
   ).

/******************************************************************************/
/* Testing                                                                    */
/******************************************************************************/

test_specific_files(Fs) :-
   parse_files(Fs).

test_all_files :-
   tell('parser.out'),
   parse_files([
      'testfiles/testok1.pas',
      'testfiles/testok2.pas',
      'testfiles/testok3.pas',
      'testfiles/testok4.pas',
      'testfiles/testok5.pas',
      'testfiles/testok6.pas',
      'testfiles/testok7.pas',
      'testfiles/testa.pas',
      'testfiles/testb.pas',
      'testfiles/testc.pas',
      'testfiles/testd.pas',
      'testfiles/teste.pas',
      'testfiles/testf.pas',
      'testfiles/testg.pas',
      'testfiles/testh.pas',
      'testfiles/testi.pas',
      'testfiles/testj.pas',
      'testfiles/testk.pas',
      'testfiles/testl.pas',
      'testfiles/testm.pas',
      'testfiles/testn.pas',
      'testfiles/testo.pas',
      'testfiles/testp.pas',
      'testfiles/testq.pas',
      'testfiles/testr.pas',
      'testfiles/tests.pas',
      'testfiles/testt.pas',
      'testfiles/testu.pas',
      'testfiles/testv.pas',
      'testfiles/testw.pas',
      'testfiles/testx.pas',
      'testfiles/testy.pas',
      'testfiles/testz.pas',
      'testfiles/fun1.pas',
      'testfiles/fun2.pas',
      'testfiles/fun3.pas',
      'testfiles/fun4.pas',
      'testfiles/fun5.pas',
      'testfiles/sem1.pas',
      'testfiles/sem2.pas',
      'testfiles/sem3.pas',
      'testfiles/sem4.pas',
      'testfiles/sem5.pas'
   ]),
   told.

parse_files([]).
parse_files([Head|Tail]) :-
   read_in(Head, Lexemes),
   lexer(Lexemes, Tokens),
   parser(Tokens, Result),
   format('Testing ~w~n~n~w~n~w~n~w~n~w end of parse~n', [Head, Lexemes, Tokens, Result, Head]),
   parse_files(Tail). 

/******************************************************************************/
/* End of program                                                             */
/******************************************************************************/
