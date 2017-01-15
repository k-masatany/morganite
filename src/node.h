#ifndef NODE_H
#define NODE_H

struct node {
  struct node *next;
  struct node *prev;
  int own_string;
  char const *name;
  int n_elems;
  struct node *elems[];
};

#endif
