/*
** lex.l - podang lexer
**
** See Copyright Notice in LICENSE file.
*/
%{
#include "y.tab.h"

int yywrap(void)
{
    return 1;
}
%}

%%

"+"     return OP_ADD;
"tasu"  return OP_ADD;
"-"     return OP_SUB;
"hiku"  return OP_SUB;
"*"     return OP_MUL;
"kake"  return OP_MUL;
"/"     return OP_DIV;
"waru"  return OP_DIV;
"\n"    return CH_NL;

([1-9][0-9]*|[0-9]) {
    int temp;
    sscanf(yytext, "%d", &temp);
    yylval.int_value = temp;
    return INTEGER;
};

([1-9][0-9]*\.[0-9]*)|(0\.[1-9]) {
    double temp;
    sscanf(yytext, "%lf", &temp);
    yylval.double_value = temp;
    return DOUBLE;
};


[ \t] ;

. {
    fprintf(stderr, "lexical error.\n");
    exit(1);
}
%%
