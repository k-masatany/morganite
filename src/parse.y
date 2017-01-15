/*
** parse.y - podang parser
**
** See Copyright Notice in LICENSE file.
*/
%{
#include <stdio.h>
#include <stdbool.h>
#define YYDEBUG 1

static void yyerror(const char *s)
{
    fputs(s, stderr);
    fputs("\n", stderr);
}
%}

%union {
    int     int_value;
    double  double_value;
	bool	boolean_value;
}

%type <double_value> expr number
%type <boolean_value> boolexpr
%token <int_value> INTEGER
%token <double_value> DOUBLE
%token <boolean_value> BOOLEAN
%token newline

%left	op_add op_sub
%left	op_mul op_div
%left	op_not
%left	op_and op_or op_nand op_nor op_xor
%right	op_bond

%%
program     :   statement
            |   program statement
            ;

statement   :   expr newline { fprintf(stdout, "%g\n", $1); }
			|   boolexpr newline { fprintf(stdout, "%d\n", $1); }
            ;

expr        :   number
            |   "(" expr ")"
            |   expr op_add expr    { $$ = $1 + $3; }
            |   expr op_sub expr    { $$ = $1 - $3; }
            |   expr op_mul expr    { $$ = $1 * $3; }
            |   expr op_div expr    { $$ = $1 / $3; }
            ;

boolexpr	:	BOOLEAN
			|   op_not boolexpr   		{ $$ = !$2; }
            |   boolexpr op_and boolexpr    { $$ = $1 && $3; }
            |   boolexpr op_or boolexpr     { $$ = $1 || $3; }
            |   boolexpr op_nand boolexpr   { $$ = !($1 && $3); }
            |   boolexpr op_nor boolexpr    { $$ = !($1 || $3); }
            |   boolexpr op_xor boolexpr    { $$ = $1 ^ $3; }
            ;

number      :   INTEGER {$$ = (double)$1; }
            |   DOUBLE
            ;
%%

int main(void)
{
    yyparse();
    printf("See you!!");
    return 0;
}
