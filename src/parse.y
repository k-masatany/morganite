/*
** parse.y - podang parser
**
** See Copyright Notice in LICENSE file.
*/
%{
#include <stdio.h>
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
}

%type <double_value> expr number
%token <int_value> INTEGER
%token <double_value> DOUBLE
%token CH_NL

%left OP_ADD OP_SUB
%left OP_MUL OP_DIV

%%
program     :   statement
            |   program statement
            ;

statement   :   expr CH_NL { fprintf(stdout, "%g\n", $1); }
            ;

expr        :   number
            |   "(" expr ")"
            |   expr OP_ADD expr    { $$ = $1 + $3; }
            |   expr OP_SUB expr    { $$ = $1 - $3; }
            |   expr OP_MUL expr    { $$ = $1 * $3; }
            |   expr OP_DIV expr    { $$ = $1 / $3; }
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
