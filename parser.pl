/******************************************************************************/
/* Prolog Lab 3                                                               */
/******************************************************************************/

:- [cmreader].

/******************************************************************************/
/* labels for the token values                                                */
/******************************************************************************/

program	-->	[256].
id			-->	[270].
lp			-->	[40].
input 	-->	[257].
output 	-->	[258].
rp 		-->	[41].
scolon 	-->	[59].
var 		-->	[259].
colon  	-->	[58].
comma  	-->   [44].
int 		-->	[260].
real 		-->	[264].
bool 		-->	[263].
begin 	-->	[261].
end 		-->	[262].
dot 		-->	[46].
assign 	-->	[271].
add 		-->   [43].
mult 		-->   [42].
num 		-->   [272].


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
var_dec_list_grmr	-->		var_dec_grmr.
var_dec_list_grmr	-->		var_dec_list_grmr, var_dec_grmr.
var_dec_grmr 		-->		id_list_grmr, colon, type_grmr, scolon.
id_list_grmr 		-->		id.
id_list_grmr 		--> 	   id_list_grmr, comma, id. 
type_grmr 			-->		int.
type_grmr 			-->		real.
type_grmr 			-->		bool.

/******************************************************************************/
/* Stat part                                                                  */
/******************************************************************************/
stat_part_grmr   	-->   	begin, stat_list_grmr, end, dot.
stat_list_grmr 	-->   	stat_grmr.
stat_list_grmr 	-->		stat_list_grmr, scolon, stat_grmr.
stat_grmr 			-->		assign_stat_grmr.
assign_stat_grmr 	-->		id, assign, expr_grmr.
expr_grmr 			-->		term_grmr.
expr_grmr 			-->		expr_grmr, add, term_grmr.
term_grmr 			-->		factor_grmr.
term_grmr 			--> 	   term_grmr, mult, factor_grmr.
factor_grmr			--> 	   lp, expr_grmr, rp.
factor_grmr 		--> 	   operand_grmr.
operand_grmr 		-->		id.
operand_grmr 		-->		num.

/******************************************************************************/
/* Testing                                                                    */
/******************************************************************************/

test_specific_files(Fs) :-
   parse_files(Fs).

test_all_files :-
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
   ]).

parse_files([]).
parse_files([Head|Tail]) :-
   read_in(Head, Lexemes),
   lexer(Lexemes, Tokens),
   parser(Tokens, Result),
   format('Testing ~w~n~n~w~n~w~n~w~n~w end of parse~n~n', Head, Lexemes, Tokens, Result, Head),
   parse_files(Tail). 

/******************************************************************************/
/* End of program                                                             */
/******************************************************************************/
