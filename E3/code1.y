%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}


%token NUMBER
%token ADD
%token SUB
%token MUL
%token DIV
%token LEFTBRACKETS
%token RIGHTBRACKETS
%left ADD SUB
%left MUL DIV
%right UMINUS

%%

lines  :    lines expr '\n'{ printf("%f\n", $2); }
| lines '\n'
|
;

expr: expr ADD expr{ $$ = $1 + $3; }
| expr SUB expr{ $$ = $1 - $3; }
| expr MUL expr{ $$ = $1 * $3; }
| expr DIV expr{ $$ = $1 / $3; }
| LEFTBRACKETS expr RIGHTBRACKETS { $$ = $2; }
| SUB expr %prec UMINUS{ $$ = -$2; }
| NUMBER
;


/*
NUMBER: '0'{ $$ = 0.0; }
| '1'{ $$ = 1.0; }
| '2'{ $$ = 2.0; }
| '3'{ $$ = 3.0; }
| '4'{ $$ = 4.0; }
| '5'{ $$ = 5.0; }
| '6'{ $$ = 6.0; }
| '7'{ $$ = 7.0; }
| '8'{ $$ = 8.0; }
| '9'{ $$ = 9.0; }
;
*/

%%


int main(void)
{
	yyin = stdin;
	do {
		yyparse();

	} while (!feof(yyin));
	return 0;
}

void yyerror(const char*s)
{
	fprintf(stderr, "Parse error : %s\n", s);
	exit(1);
}


int yylex()
{
	int t;
	//t=getchar();
	
	/*
	if(t=='+')
		return ADD;
	if(t=='-')
		return SUB;
	if(t=='*')
		return MUL;
	if(t=='/')
		return DIV;
	if(t=='(')
		return LEFTBRACKETS;
	if(t==')')
		return RIGHTBRACKETS;
	else
		return t;
	*/

	while (1)
	{
		t = getchar();
		if (t == ' ' || t == '\t')
		{
			continue;//do nothing
		}
		if(t=='+')
            return ADD;
        if(t=='-')
            return SUB;
        if(t=='*')
            return MUL;
        if(t=='/')
            return DIV;
        if(t=='(')
            return LEFTBRACKETS;
        if(t==')')
            return RIGHTBRACKETS;

		else if (isdigit(t))
		{
			yylval = 0;
			while (isdigit(t))
			{
				yylval = yylval * 10 + t - '0';
				t = getchar();
			}
			ungetc(t, stdin);
			return NUMBER;

		}
		else
		{
			return t;
		}
	}

}
