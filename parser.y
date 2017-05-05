%{
/* libraries */
#include <stdio.h>
#include <stdlib.h>

/* external variables */
extern int yylex();
extern FILE *yyin;
extern FILE *yyout;
void yyerror(const char *msg);

/* global variables */
FILE *infile;
FILE *outfile;
char line[256];
int error_flag;
%}

%token IDENTIFIER ASSIGN LBRACE RBRACE SEMICOLON
%left OP

%start line
%%

line : statement;

statement
      : assignment
      ;

assignment
      : expression
      | IDENTIFIER ASSIGN expression SEMICOLON {printf("asdfasdf");}
      ;

expression
      : IDENTIFIER
      | expression OP expression
      | LBRACE expression RBRACE
      ;

%%
void yyerror(const char *msg) {
  if (error_flag != 2)
    error_flag = 1;
}

int main() {
  // Redirect Output
  yyout = fopen("out.txt", "w");
  infile = fopen("in.txt", "r");
  yyin = fopen("in.txt", "r");

  while (fgets(line, sizeof(line), infile) != NULL) {
    error_flag = 0;
    yyparse();
    printf("%d\n", error_flag);
    if (error_flag == 1) {
      fprintf(yyout, "Failure| %s", line);
      fprintf(yyout, "       ! syntax error.\n");
    } else if (error_flag == 2) {
        fprintf(yyout, "Failure| %s", line);
        fprintf(yyout, "       ! unrecognized character.\n");
    } else {
      fprintf(yyout, "Success| %s", line);
    }
    printf(".....\n");
  }


  // Finishing
  fclose(infile);
  fclose(yyin);
  fclose(yyout);
  printf("Complete.\n");
  return 0;
}
