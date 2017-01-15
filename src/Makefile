TARGET = mycalc
BISON_SRC = parse.y
BISON_H   = parse.tab.h
BISON_C   = parse.tab.c
BISON_O   = parse.tab.o
BISON_OUT = $(BISON_C) $(BISON_H) $(TARGET).output
FLEX_SRC  = lex.l
FLEX_C    = lex.yy.c
FLEX_O    = lex.yy.o
MAIN_C    = main.c
YACC_C   = $(BISON_C) $(FLEX_C)
HEADERS   = $(FLEX_H) $(BISON_H)

all : $(TARGET)

$(TARGET) : $(YACC_C)
	cc -o $@ $(MAIN_C) $(YACC_C) -lfl

$(FLEX_C) : $(FLEX_SRC) $(BISON_H)
	lex $(FLEX_SRC)

$(BISON_OUT) : $(BISON_SRC)
	bison -dv $(BISON_SRC)

.c.o :
	gcc -c $<

clean :
	rm -f $(TARGET)
	rm -f $(YACC_C)
	rm -f *.output
	rm -f *.o

$(FLEX_O): $(FLEX_C) $(BISON_H)
$(BISON_O): $(BISON_C) $(BISON_H)
