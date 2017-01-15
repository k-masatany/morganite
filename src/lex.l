/*
** lex.l - podang lexer
**
** See Copyright Notice in LICENSE file.
*/
%{
#include <string.h>
#include <stdbool.h>
#include "y.tab.h"

int yywrap(void)
{
    return 1;
}
%}

%%

"+"     return op_add;
"-"     return op_sub;
"*"     return op_mul;
"/"     return op_div;
"="		return op_bond;
"and"	return op_and;
"or"	return op_or;
"!"		return op_not;
"not"	return op_not;
"nand"	return op_nand;
"nor"	return op_nor;
"xor"	return op_xor;
"\n"    return newline;

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

(true|True|TRUE) {
    yylval.boolean_value = true;
    return BOOLEAN;
};

(false|False|FALSE) {
    yylval.boolean_value = false;
    return BOOLEAN;
};

[ \t] ;

. {
    fprintf(stderr, "lexical error.\n");
    exit(1);
}
%%
