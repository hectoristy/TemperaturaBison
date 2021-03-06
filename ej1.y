%{
int numMedidas = 0;
#include <stdio.h>
%}
%union{
int valInt;
float valFloat;
}
%token tCentigrados tFarenheit
%token <valInt> tHora
%token <valFloat> tValorTemperatura
%type <valFloat> TEMPERATURA MEDICION LISTA_TEMPERATURAS
%start S
%%
S : LISTA_TEMPERATURAS {printf("Temperatura Media en Total: %f C\n",
$1/(float)numMedidas);}
 ;
LISTA_TEMPERATURAS : LISTA_TEMPERATURAS MEDICION {$$ = $1 + $2; numMedidas++;}
 | MEDICION {$$ = $1; numMedidas++;}
 ;
MEDICION : tHora TEMPERATURA { if ($1 == 12) {
 printf ("Temp a las 12 son: %f C\n", $2);
 }
 $$ = $2;
 }
 ;
TEMPERATURA : tValorTemperatura tCentigrados {$$ = $1;}
 | tValorTemperatura tFarenheit {$$ = (($1 - 32.0) * 5.0) / 9.0;}
 ;
%%
int yyerror(char *m){
   fprintf(stderr,"Error: %s\n",m);
   return(1);
 }
main() {
 yyparse();
}
