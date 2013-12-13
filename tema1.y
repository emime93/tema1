%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token ID TIP BGIN END ASSIGN NR 
%start program
%%
program: declaratii_globale functii functie_principala {printf("program corect sintactic\n");}
       ;
/* DECLARATII GLOBALE */
declaratii_globale : declaratie_globala ';'
                   | declaratii_globale declaratie_globala ';'
                   ;
declaratie_globala : TIP ID
                   | TIP ID '[' NR ']'
                   | TIP ID '[' NR ']' '[' NR ']'
                   | TIP ID '(' declaratie_globala ')'
                   | TIP ID '(' ')'
                   ;


/* FUNCTII */
functii            : TIP ID '(' ')' functie 
                   | functii TIP ID '(' ')' functie 
                   | /*EPSILON*/
                   ;

functie            : BGIN declaratii_locale lista_instructiuni END
                   ;

declaratii_locale  : declaratie_locala ';'
                   | declaratii_locale declaratie_locala ';'
                   ;

declaratie_locala  : TIP ID
                   | TIP ID '[' NR ']'
                   | TIP ID '[' NR ']' '[' NR ']'
                   ;

functie_principala : BGIN declaratii_locale lista_instructiuni END
                   ;
lista_instructiuni : instructiune ';'
                   | lista_instructiuni instructiune ';'
                   ;
instructiune       : ID ASSIGN ID
                   | ID ASSIGN NR
                   | ID '(' lista_apel ')'
                   ;

lista_apel         : NR
                   | ID
                   | lista_apel ',' NR
                   | lista_apel ',' ID
                   | /* EPSILON */
                   ;

%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
yyin=fopen(argv[1],"r");
yyparse();
} 