# Nicholas Krisa (cssc0869)
# CS530. Guy Leonard. Spring 2017.
# Assignment 3 - Parser
# Makefile

CC = cc
YACC = yacc -d
LEX = lex

parser: y.tab.c
	$(CC) -o a3 y.tab.c lex.yy.c
y.tab.c: parser.y lex.yy.c
	$(YACC) parser.y
lex.yy.c: scanner.l
	$(LEX) scanner.l

clean:
	-rm -f *.o lex.yy.c *.tab.* a3 *.output
