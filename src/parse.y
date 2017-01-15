/*
** parse.y - podang parser
**
** See Copyright Notice in LICENSE file.
*/
%{
#include <stdio.h>
#include <stdarg.h>
#include <stdlib.h>
#include "node.h"
#define YYDEBUG 1

extern void print(const char* format, ...);
extern struct node *mk_node(char const *name, int n, ...);
extern struct node *mk_atom(char *name);
extern char *yytext;
extern struct node *nodes;

static void yyerror(const char *s)
{
    fputs(s, stderr);
    fputs("\n", stderr);
}
%}

%union {
    struct node* nd;
}

%type  <nd> statement expr ident lit str
%token FAT_ARROW
%token LIT_BYTE
%token LIT_CHAR
%token LIT_INTEGER
%token LIT_FLOAT
%token LIT_STR
%token TRUE
%token FALSE
%token IDENT

%left	OP_PLUSE OP_MINUS
%left	OP_MULTI OP_DIVIS
%left	OP_AND OP_OR OP_XOR
%left	OP_NOT
%right  OP_BIND

%right  OP_PRINT

%%
program     :   statement
            |   program statement
            ;

statement   :   expr
            |   OP_PRINT lit    { $$ = printf("nodes %s\n", nodes->name); }
            ;

expr        :   lit
            |   ident
            |   ident OP_BIND expr    { $$ = mk_node("test", 2, $1, $3); }
            ;

ident       : IDENT             { $$ = mk_node("ident", 1, mk_atom(yytext)); }
            ;

lit         : LIT_BYTE          { $$ = mk_node("LitByte", 1, mk_atom(yytext)); }
            | LIT_CHAR          { $$ = mk_node("LitChar", 1, mk_atom(yytext)); }
            | LIT_INTEGER       { $$ = mk_node("LitInteger", 1, mk_atom(yytext)); }
            | LIT_FLOAT         { $$ = mk_node("LitFloat", 1, mk_atom(yytext)); }
            | TRUE              { $$ = mk_node("LitBool", 1, mk_atom(yytext)); }
            | FALSE             { $$ = mk_node("LitBool", 1, mk_atom(yytext)); }
            | str
            ;

str         : LIT_STR           { $$ = mk_node("LitStr", 1, mk_atom(yytext), mk_atom("CookedStr")); }
            ;
%%
