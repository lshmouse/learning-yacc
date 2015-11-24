.PHONY : dummy

all : dummy
	yacc -dv calculator.y
	lex calculator.l
	gcc -o calculator lex.yy.c y.tab.c

clean : dummy
	rm -rf lex.yy.c calculator y.output y.tab.c y.tab.h
