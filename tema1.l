%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
"@add"<[a-z]+".h"> {return LIB;}
"@define" {return DEF;}
"intreg"|"real"|"caracter"|"sir"|"const intreg"|"const caracter"|"const real"|"const intreg" {return TIP;}
"@{" {return BGIN;}
"}@" {return END;}
"daca" {return IFF;}
"altfel" {return ELSEE;}
"pentru" {return FOR;}
"cat_timp" {return WHILE;}
"//"[a-zA-Z0-9 ]* {return COMM;}
"clasa"|"structura" {return STRUCT;}
"return" {return RETURN;}
>|<|>=|<= {return CMP_OP_ING;}
== {return CMP_OP_EG;}
"++"|"--" {return INC_DEC;}
[A-Z]+ {return MCRO;}
_[_a-zA-Z][_a-zA-Z0-9]* {return ID;}
"=" {return ASSIGN;}
[0-9]+ {return NR;}
[ \t] ;
\n {yylineno++;}
. {return yytext[0];}

 