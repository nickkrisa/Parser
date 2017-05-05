%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

extern int error_flag;
%}

digit [0-9]
alphabetic    [A-Za-z_]
alphanumeric  ({alphabetic}|{digit})
op [+\-/*%]

%%  /* Token Definitions */
[ \t]*                         ;

{alphabetic}{alphanumeric}*     {printf("%d\n", IDENTIFIER);if(error_flag == 0) return IDENTIFIER;}
{op}                            {printf("%d\n", OP);if(error_flag == 0) return OP;}
"="                             {printf("%d\n", ASSIGN);if(error_flag == 0) return ASSIGN;}
";"                             {printf("%d\n", SEMICOLON); if(error_flag == 0) return SEMICOLON;}
"("                             {printf("%d\n", LBRACE);if(error_flag == 0) return LBRACE;}
")"                             {printf("%d\n", RBRACE);if(error_flag == 0) return RBRACE;}
.                               {error_flag = 2;if(error_flag == 0) return yytext[0];}
[\n]*                           {printf("NEWLINE\n"); return 0;}
%%

int yywrap() {
  return 1;
}
