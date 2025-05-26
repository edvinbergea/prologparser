/******************************************************************************/
/* Prolog Lab 3                                                               */
/******************************************************************************/

/******************************************************************************/
/* labels for the token values                                                */
/******************************************************************************/

program		-->		[256].
id			-->		[270].
lp			-->		[40].
input 		-->		[257].
output 		-->		[258].
rp 			-->		[41].
scolon 		-->		[59].
var 		-->		[259].
colon  		-->		[58].
comma  		-->  	[44].
int 		-->		[260].
real 		-->		[264].
bool 		-->		[263].
begin 		-->		[261].
end 		-->		[262].
dot 		-->		[46].
assign 		-->		[271].
add 		--> 	[43].
mult 		-->		[42].
num 		-->		[272].


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
var_part_grmr    	--> 	var, var_dec_list_grmr.
var_dec_list_grmr	-->		var_dec_grmr.
var_dec_list_grmr	-->		var_dec_list_grmr, var_dec_grmr.
var_dec_grmr 		-->		id_list_grmr, colon, type_grmr, scolon.
id_list_grmr 		-->		id.
id_list_grmr 		--> 	id_list_grmr, comma, id. 
type_grmr 			-->		int.
type_grmr 			-->		real.
type_grmr 			-->		bool.

/******************************************************************************/
/* Stat part                                                                  */
/******************************************************************************/
stat_part_grmr     	-->  	begin, stat_list_grmr, end, dot.
stat_list_grmr 		--> 	stat_grmr.
stat_list_grmr 		-->		stat_list_grmr, scolon, stat_grmr.
stat_grmr 			-->		assign_stat_grmr.
assign_stat_grmr 	-->		id, assign, expr_grmr.
expr_grmr 			-->		term_grmr.
expr_grmr 			-->		expr_grmr, add, term_grmr.
term_grmr 			-->		factor_grmr.
term_grmr 			--> 	term_grmr, mult, factor_grmr.
factor_grmr			--> 	lp, expr_grmr, rp.
factor_grmr 		--> 	operand_grmr.
operand_grmr 		-->		id.
operand_grmr 		-->		num.

/******************************************************************************/
/* Testing the system: this may be done stepwise in Prolog                    */
/* below are some examples of a "bottom-up" approach - start with simple      */
/* tests and buid up until a whole program can be tested                      */
/******************************************************************************/
/* Stat part                                                                  */
/******************************************************************************/
/*  op(['+'], []).                                                            */
/*  op(['-'], []).                                                            */
/*  op(['*'], []).                                                            */
/*  op(['/'], []).                                                            */
/*  addop(['+'], []).                                                         */
/*  addop(['-'], []).                                                         */
/*  mulop(['*'], []).                                                         */
/*  mulop(['/'], []).                                                         */
/*  factor([a], []).                                                          */
/*  factor(['(', a, ')'], []).                                                */
/*  term([a], []).                                                            */
/*  term([a, '*', a], []).                                                    */
/*  expr([a], []).                                                            */
/*  expr([a, '*', a], []).                                                    */
/*  assign_stat([a, assign, b], []).                                          */
/*  assign_stat([a, assign, b, '*', c], []).                                  */
/*  stat([a, assign, b], []).                                                 */
/*  stat([a, assign, b, '*', c], []).                                         */
/*  stat_list([a, assign, b], []).                                            */
/*  stat_list([a, assign, b, '*', c], []).                                    */
/*  stat_list([a, assign, b, ';', a, assign, c], []).                         */
/*  stat_list([a, assign, b, '*', c, ';', a, assign, b, '*', c], []).         */
/*  stat_part([begin, a, assign, b, '*', c, end, '.'], []).                   */
/******************************************************************************/
/* Var part                                                                   */
/******************************************************************************/
/* typ([integer], []).                                                        */
/* typ([real], []).                                                           */
/* typ([boolean], []).                                                        */
/* id([a], []).                                                               */
/* id([b], []).                                                               */
/* id([c], []).                                                               */
/* id_list([a], []).                                                          */
/* id_list([a, ',', b], []).                                                  */
/* id_list([a, ',', b, ',', c], []).                                          */
/* var_dec([a, ':', integer], []).                                            */
/* var_dec_list([a, ':', integer], []).                                       */
/* var_dec_list([a, ':', integer, b, ':', real], []).                         */
/* var_part([var, a, ':', integer], []).                                      */
/******************************************************************************/
/* Program header                                                             */
/******************************************************************************/
/* prog_head([program, c, '(', input, ',', output, ')', ';'], []).            */
/******************************************************************************/

/******************************************************************************/
/* Whole program                                                              */
/******************************************************************************/
/* program([program, c, '(', input, ',', output, ')', ';',                    */
/*          var, a,    ':', integer, ';',                                     */
/*               b, ',', c, ':', real,    ';',                                */
/*          begin,                                                            */
/*             a, assign, b, '*', c, ';',                                     */  
/*             a, assign, b, '+', c,                                          */
/*          end, '.'], []).                                                   */
/******************************************************************************/

/******************************************************************************/
/* Define the above tests                                                     */
/******************************************************************************/

testph :- prog_head_grmr([program, id, lp, input, comma, output, rp, scolon], []).
testpr :-   program_grmr([program, id, lp, input, comma, output, rp, scolon,                    
          var, id, colon, integer, scolon,                                     
               id, comma, id, colon, real, scolon,                                
          begin,                                                            
             id, assign, id, mult, id, scolon,                                      
             id, assign, id, '+', c,                                          
          end, '.'], []).

/******************************************************************************/
/* End of program                                                             */
/******************************************************************************/
