%{
#include <stdio.h>
#include <stdlib.h>
#define  YYDEBUG 1
%}
%union {
    int     int_value;
    double  double_value;
}
%token <double_value> DOUBLE_LITERAL
%token ADD SUB MUL DIV CR LEFT RIGHT
%type <double_value> L1 L2 L3 L4
%%
line_list
    : line
    | line_list line
    ;
line
    : L1 CR
    {   
        printf(">>%lf\n> ", $1);
        fflush(stdout);
    }   
L1
    : L2
    | L1 ADD L2
    {
        $$ = $1 + $3;
    }
    | L1 SUB L2
    {
        $$ = $1 - $3;
    }
    ;
L2 
    : L3
    | L2 MUL L3
    {
        $$ = $1 * $3;
    }
    | L2 DIV L3
    {
        $$ = $1 / $3;
    }
    ;
L3 
    : L4
    | LEFT L1 RIGHT
    {
        $$ = $2;
    }
    ;
L4 
    : DOUBLE_LITERAL
    ;
%%
int
yyerror(char * str)
{
    extern char * yytext;
    fprintf(stderr, "parser error near %s\n", yytext);
    return 0;
}

int main(void)
{
    extern int yyparse(void);
    extern FILE * yyin;

    printf("> ");
    fflush(stdout);
    yyin = stdin;
    if (yyparse()) {
        fprintf(stderr, "Error ! Error ! Error !\n");
        exit(1);
    }
}
