%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
"intreg"|"real"|"caracter"|"propozitie" {return TIP;}
"start_functie" {return BGIN;}
"sfarsit_functie" {return END;}
_[_a-zA-Z][_a-zA-Z0-9]* {return ID;}
"=" {return ASSIGN;}
[0-9]+ {return NR;}
[ \t] ;
\n {yylineno++;}
. {return yytext[0];}

 