%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#include<string.h>
#ifndef YYSTYPE
#define YYSTYPE char*
#endif
char idStr[50];
char numStr[50];
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char*s);
%}


%token NUMBER
%token ID
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

lines  :    lines expr '\n'{ printf("%s\n", $2); }
| lines '\n'
|
;

expr: expr ADD expr{ $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1);strcat($$,$3);strcat($$,"+ "); }
| expr SUB expr{ $$ = (char*)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"- "); }
| expr MUL expr{ $$ = (char*)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"* "); }
| expr DIV expr{ $$ = (char*)malloc(50*sizeof(char));strcpy($$,$1);strcat($$,$3);strcat($$,"/ ");}
| LEFTBRACKETS expr RIGHTBRACKETS { $$ = $2; }
//| '-' expr %prec UMINUS{ $$ = -$2; }
| NUMBER {$$ = (char*)malloc(50*sizeof(char));strcpy($$,$1);strcat($$," ");}
| ID {$$ = (char*)malloc(50*sizeof(char));strcpy($$,$1);strcat($$," ");}
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
		if((t>='0'&&t<='9'))
		{
			int ti=0;
			while((t>='0'&&t<='9'))
			{
				numStr[ti]=t;
				t=getchar();
				ti++;
			}
			numStr[ti]='\0';
			yylval=numStr;
			ungetc(t,stdin);
			return NUMBER;
		}
		if((t>='a'&&t<='z')||(t>='A'&&t<='Z')||(t=='_'))
		{
				int ti=0;
				while((t>='a'&&t<='z')||(t>='A'&&t<='Z')||(t=='_')||(t>='0'&&t<='9'))
				{
					idStr[ti]=t;
					ti++;
					t=getchar();
				}
				idStr[ti]='\0';
				yylval=idStr;
				ungetc(t,stdin);
				return ID;
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
			return  LEFTBRACKETS;
		if(t==')')
			return RIGHTBRACKETS;
		else
		{
			return t;
		}
	}

}
