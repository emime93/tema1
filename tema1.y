%{
#include <stdio.h>
extern FILE* yyin;
extern char* yytext;
extern int yylineno;
%}
%token ID TIP BGIN END ASSIGN NR DEF MCRO LIB IFF ELSEE FOR WHILE CMP_OP_ING INC_DEC CMP_OP_EG STRUCT RETURN COMM
%start program
%%
program            : bloc_de_start structuri declaratii_globale functii {printf("program corect sintactic\n");}
                   | bloc_de_start declaratii_globale functii {printf("program corect sintactic\n");}
                   ;

/* DECLARATII GLOBALE */

bloc_de_start      : start_statement
                   | bloc_de_start start_statement
                   ;

start_statement    : DEF MCRO NR
                   | LIB
                   ;

declaratii_globale : declaratie_globala ';'
                   | declaratii_globale declaratie_globala ';'
                   | COMM
                   | declaratii_globale COMM
                   ;

declaratie_globala : TIP ID
                   | TIP ID '[' NR ']'
                   | TIP ID '[' NR ']' '[' NR ']'
                   | tip_functie
                   ;

tip_functie        : TIP ID '(' ')'
                   | TIP ID '(' lista_param_decl ')'
                   | TIP ID ':' ID '(' ')'
                   | TIP ID ':' ID '(' lista_param_decl ')'
                   ;

lista_param_decl   : declaratie_globala
                   | lista_param_decl ',' declaratie_globala
                   ;

expresie           : e '+' e
                   | e '*' e
                   | e '/' e
                   | e '-' e
                   ;

e                  : NR
                   | ID
                   ;
/* FUNCTII */
functii            : tip_functie functie 
                   | functii tip_functie functie
                   ;

functie            : BGIN declaratii_locale lista_instructiuni lista_instr_ctrl return_type END
                   | BGIN declaratii_locale lista_instructiuni return_type END
                   | BGIN return_type END
                   | BGIN declaratii_locale return_type END
                   | BGIN lista_instructiuni return_type END
                   ;
return_type        : RETURN ID ';'
                   | RETURN NR ';' 
                   |
                   ;

declaratii_locale  : declaratie_locala ';'
                   | declaratii_locale declaratie_locala ';'
                   ;

declaratie_locala  : TIP ID 
                   | TIP ID '[' NR ']'
                   | TIP ID '[' NR ']' '[' NR ']'
                   | /* Epsilon */
                   ;

lista_instructiuni : instructiune ';'
                   | lista_instructiuni instructiune ';'
                   | COMM
                   | lista_instructiuni COMM
                   ;

instructiune       : ID ASSIGN ID
                   | ID ASSIGN NR
                   | ID ASSIGN expresie
                   | ID ASSIGN INC_DEC ID
                   | ID ASSIGN INC_DEC NR
                   | ID ASSIGN INC_DEC '(' expresie ')'
                   | ID '(' lista_apel ')'
                   | '[' ID ID ']'
                   | '[' ID ID '(' lista_apel ')' ']'
                   | ID INC_DEC
                   ;

lista_instr_ctrl   : instructiune_ctrl
                   | lista_instr_ctrl instructiune_ctrl
                   ;

instructiune_ctrl  : IFF '(' list_exp ')' '{' lista_instructiuni '}' ELSEE '{' '}'
                   | IFF '(' list_exp ')' '{' '}' ELSEE '{' '}'
                   | IFF '(' list_exp ')' '{' lista_instructiuni '}'
                   | IFF '(' list_exp ')' '{' '}'
                   | IFF '(' list_exp ')' '{' lista_instructiuni '}' ELSEE '{' lista_instructiuni '}'
                   | IFF '(' list_exp ')' '{' '}' ELSEE '{' lista_instructiuni '}'
                   | FOR '(' ID ASSIGN NR ';' ID CMP_OP_ING NR ';' ID INC_DEC')' '{' lista_instructiuni '}'
                   | FOR '(' ID ASSIGN NR ';' ID CMP_OP_ING NR ';' ID INC_DEC')' '{' '}'
                   | WHILE '(' ID CMP_OP_ING NR ')' '{' lista_instructiuni '}'
                   | WHILE '(' ID CMP_OP_ING NR ')' '{' '}'
                   | WHILE '(' ID CMP_OP_EG NR ')' '{' lista_instructiuni '}'
                   | WHILE '(' ID CMP_OP_EG NR ')' '{' '}'
                   ;

list_exp           : exp
                   | list_exp '^' exp
                   | list_exp '|' exp
                   ;

exp                : '!' ID
                   | ID
                   | ID operator NR
                   | ID operator ID
                   | '!' ID operator NR
                   | '!' ID operator ID
                   ;
                   
operator           : CMP_OP_ING
                   | CMP_OP_EG
                   | CMP_OP_ING CMP_OP_EG
                   ;

lista_apel         : NR
                   | ID
                   | lista_apel ',' NR
                   | lista_apel ',' ID
                   | expresie
                   | lista_apel ',' expresie
                   | MCRO
                   | lista_apel ',' MCRO
                   | /* EPSILON */
                   ;

structuri          : structura 
                   | structuri structura
                   ;

structura          : STRUCT ID '{' '}' 
                   | STRUCT ID '{' declaratii_globale '}'
                   | STRUCT ID '{' declaratii_globale functii '}'
                   ;
%%
int yyerror(char * s){
printf("eroare: %s la linia:%d\n",s,yylineno);
}

int main(int argc, char** argv){
yyin=fopen(argv[1],"r");
yyparse();
} 