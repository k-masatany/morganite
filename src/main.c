/*
** parse.y - podang parser
**
** See Copyright Notice in LICENSE file.
*/
#include <stdarg.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <malloc.h>
#include "node.h"
#include "parse.tab.h"

struct node *nodes = NULL;
int n_nodes = 0;

void print(const char* format, ...) {
    va_list args;
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
}

struct node *mk_node(char const *name, int n, ...) {
    va_list ap;
    int i = 0;
    unsigned sz = sizeof(struct node) + (n * sizeof(struct node *));
    struct node *nn, *nd = (struct node *)malloc(sz);
    print("# sizeof(nodes) : %d\n", malloc_usable_size(nodes));
    print("# New %d-ary node: %s = %p\n", n, name, nd);

    nd->own_string = 0;
    nd->prev = NULL;
    nd->next = nodes;
    if (nodes) {
        nodes->prev = nd;
    }
    nodes = nd;

    nd->name = name;
    nd->n_elems = n;

    va_start(ap, n);
    while (i < n) {
        nn = va_arg(ap, struct node *);
        print("#   arg[%d]: %p\n", i, nn);
        print("#            (%s ...)\n", nn->name);
        nd->elems[i++] = nn;
    }
    va_end(ap);
    n_nodes++;
    return nd;
}

struct node *mk_atom(char *name) {
    struct node *nd = mk_node((char const *)strdup(name), 0);
    nd->own_string = 1;
    return nd;
}

int main(void)
{
    yyparse();
    return 0;
}
