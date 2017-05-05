LEX = lex
YACC = yacc -d
CC = cc

a3: y.tab.o lex.yy.o
	$(CC) -o a3 y.tab.o lex.yy.o -ll -lm

lex.yy.o: lex.yy.c y.tab.h
lex.yy.o y.tab.o: a3.h

y.tab.c y.tab.h: parser.y
	$(YACC) -v parser.y

lex.yy.c: scanner.l
	$(LEX) scanner.l

clean:
	-rm -f *.o lex.yy.c *.tab.* a3 *.output
