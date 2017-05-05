/* Nicholas Krisa (cssc0869)
 * CS530. Guy Leonard. Spring 2017.
 * Assignment #3 - Parser
 * parser.y
 */

%{
/* libraries */
#include <stdio.h>
#include <stdlib.h>

/* external variables */
extern int yylex();
extern FILE *yyin;
void yyerror(const char *msg);

/* global variables */
int error_flag;
%}

%token IDENTIFIER ASSIGN LBRACE RBRACE SEMICOLON
%left OP

%start line
%%
line
      :
      | line assignment
      | line error
      ;

assignment
      : expression
      | IDENTIFIER ASSIGN expression SEMICOLON
      ;

expression
      : factor
      | expression OP factor
      ;

factor
      : IDENTIFIER
      | LBRACE expression RBRACE
      ;
%%

void yyerror(const char *msg) {
  if (error_flag != 2)
    error_flag = 1;
}

int main() {
  FILE *infile;
  FILE *outfile;
  char line[1000];

  // Redirect Output
  outfile = fopen("out.txt", "w");
  infile = fopen("in.txt", "r");
  yyin = fopen("in.txt", "r");

  // Start
  printf("Nicholas Krisa (cssc0869).\n");
  printf("CS530. Guy Leonard. Spring 2017.\n");
  printf("Assignment #3 - Parser.\n");
  printf("out.txt\n\n");
  printf("Parsing...\n");

  fprintf(outfile, "Nicholas Krisa (cssc0869).\n");
  fprintf(outfile, "CS530. Guy Leonard. Spring 2017.\n");
  fprintf(outfile, "Assignment #3 - Parser.\n\n");

  // store next line for printing
  while (fgets(line, sizeof(line), infile) != NULL) {

    // skip blank lines
    if (line[0] == '\n')
      continue;

    // Parse the next line of yyin
    error_flag = 0;
    yyparse();

    // Print Success or Failure to outfile
    if (error_flag == 1) {
      fprintf(outfile, "Failure| %s", line);
      fprintf(outfile, "       ! syntax error.\n");
    } else if (error_flag == 2) {
        fprintf(outfile, "Failure| %s", line);
        fprintf(outfile, "       ! unrecognized character.\n");
    } else {
      fprintf(outfile, "Success| %s", line);
    }

  } // end while

  // Finishing
  fclose(infile);
  fclose(outfile);
  fclose(yyin);
  printf("Complete.\n");
  return 0;
}
