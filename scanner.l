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

{alphabetic}{alphanumeric}*     {return IDENTIFIER;}
{op}                            {return OP;}
"="                             {return ASSIGN;}
";"                             {return SEMICOLON;}
"("                             {return LBRACE;}
")"                             {return RBRACE;}
.                               {return yytext[0];}
[\n]*                           {return 0;}
%%

int yywrap() {
  return 1;
}
