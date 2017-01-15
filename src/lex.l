/*
** lex.l - podang lexer
**
** See Copyright Notice in LICENSE file.
*/
%{
#include <string.h>
#include <stdbool.h>
#include "node.h"
#include "parse.tab.h"

int yywrap(void)
{
    return 1;
}
%}

%%

"+"         return OP_PLUSE;
"-"         return OP_MINUS;
"*"         return OP_MULTI;
"/"         return OP_DIVIS;
"="         return OP_BIND;
"and"       return OP_AND;
"or"        return OP_OR;
"!"         return OP_NOT;
"not"       return OP_NOT;
"xor"       return OP_XOR;
"println"   return OP_PRINT;

([0-9]|[1-9][0-9]*) {
    fprintf(stderr, "lex \"integer\" : %s\n", yytext);
    return LIT_INTEGER;
};

([1-9][0-9]*\.[0-9]*)|(0\.[1-9]) {
    fprintf(stderr, "lex \"double\" : %s\n", yytext);
    return LIT_FLOAT;
};

(true|True|TRUE) {
    fprintf(stderr, "lex \"true\" : %s\n", yytext);
    return TRUE;
};

(false|False|FALSE) {
    fprintf(stderr, "lex \"false\" : %s\n", yytext);
    return FALSE;
};

([a-z]|[a-z][0-9a-zA-Z_]+) {
    fprintf(stderr, "lex \"variable\" : %s\n", yytext);
    return IDENT;
}


[ \t] ;

. {
    fprintf(stderr, "lexical error.\n");
    // exit(1);
}
%%
