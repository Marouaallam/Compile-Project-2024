%{
    
    extern nb_ligne;
    extern col;
    int MAX;
    #include "syntaxique.tab.h"
	#include "quad.h"
	#include "ts.h"
    extern YYSTYPE yylval;
%}
lettre [a-zA-Z]
chiffre [0-9]
comment %.*
IDF {lettre}({lettre}|{chiffre})*
int {chiffre}+|"+"{chiffre}+|"-"{chiffre}+
real {chiffre}+"."{chiffre}+|[\+\-]{chiffre}+"."{chiffre}+
char "\'"."\'" 
string \"([^\"\\]|\\.)*\"

%%

"ROUTINE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_ROUTINE;col=col+yyleng;}
"ENDR" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_ENDR;col=col+yyleng;}
"PROGRAM" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_PROG;col=col+yyleng;}
"END" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_END;col=col+yyleng;}
"DIMENSION" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_DIMENSION;col=col+yyleng;}
"INTEGER" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_INTEGER;col=col+yyleng;}
"REAL" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_REAL;col=col+yyleng;}
"LOGICAL" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_LOGICAL;col=col+yyleng;}
"CHARACTER" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_CHARACTER;col=col+yyleng;}
"TRUE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_TRUE;col=col+yyleng;}
"FALSE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_FALSE;col=col+yyleng;}
"READ" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_READ;col=col+yyleng;}
"WRITE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_WRITE;col=col+yyleng;}
"IF" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_IF;col=col+yyleng;}
"THEN" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_THEN;col=col+yyleng;}
"ELSE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_ELSE;col=col+yyleng;}
"ENDIF" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_ENDIF;col=col+yyleng;}
"DOWHILE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_DOWHILE;col=col+yyleng;}
"ENDDO" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_ENDDO;col=col+yyleng;}
"CALL" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_CALL;col=col+yyleng;}
"EQUIVALENCE" {rechercher(yytext,"Mot cle",0,0, 1); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_EQUIVALENCE;col=col+yyleng;}
".OR." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_OR;col=col+yyleng;}
".AND." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_AND;col=col+yyleng;}
".GT." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_GT;col=col+yyleng;}
".GE." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_GE;col=col+yyleng;}
".EQ." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_EQ;col=col+yyleng;}
".NE." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_NE;col=col+yyleng;}
".LE." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_LE;col=col+yyleng;}
".LT." {rechercher(yytext,"Separateur",0,0,2); printf (" L entite lexicale reconnue est %s \n", yytext);return MC_LT;col=col+yyleng;}


{char}    {yylval.string = strdup(yytext); rechercher(yytext,"idf","char",0,0); col=col+strlen(yytext); printf(" lentite reconnue est %s \n",yytext); return charr;}
{string}  {
	yylval.string = strdup(yytext);
	rechercher(yytext,"idf","string",0,0); 
	col= col + strlen(yytext);
	printf(" L entite lexicale reconnue est %s \n", yytext);
	return string ;
}
{real}   {
	yylval.real = atof(yytext);
	rechercher(yytext,"idf","real",atof(yytext),0); 
	    col= col + strlen(yytext);
		if ((atof(yytext)>= -32768.32767) && (atof(yytext)<=32767.32767)){
				
				printf (" L entite reconnue est %s \n", yytext);
			}else {
				printf ("file: , Erreur lexicale real trop long(ligne : %d , colonne: %d) : la valeur d'un nombre reel est comprise entre -32768.32767 et 32767.32767 \n", nb_ligne, col);
				
			}
			return real;
		}

{IDF} {
	yylval.string = strdup(yytext);
	col= col + strlen(yytext);
	if (yyleng<=10) {printf(" L entite lexicale reconnue est %s \n", yytext);}
    else printf(" file:,erreur lexical ligne %d la colone %d : IDF trop long superieur a 10 \n",nb_ligne,col);
    return idf;
}

{int} {
	    col= col + strlen(yytext);
		if ((atoi(yytext)>= -32768) && (atoi(yytext)<=32767)){
				yylval.entier = atoi(yytext);
				rechercher(yytext,"idf","int",atof(yytext),0); 
				printf ("L entite lexicale reconnue est %s \n", yytext);
			}else {
				printf ("file: , Erreur lexicale integer trop long  (ligne : %d , colonne: %d) : la valeur d'un nombre entier est comprise entre -32768 et 32767 \n", nb_ligne, col);
				
			}
			return intt;
}


{comment} {col++;}


"=" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return AFF;col=col+yyleng;}
";" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return PVG;col=col+yyleng;}
":" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return DP;col=col+yyleng;}
"," {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return VG;col=col+yyleng;}
"(" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return PRL;col=col+yyleng;}
")" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return PRR;col=col+yyleng;}
"\"" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return GUI;col=col+yyleng;}
"+" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return ADDITION;col=col+yyleng;}
"-" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return SOUSTRACTION;col=col+yyleng;}
"*" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return MULTIPLICATION;col=col+yyleng;}
"/" {rechercher(yytext,"Separateur",0,0,2);printf (" L entite lexicale reconnue est %s \n", yytext);return DIVISION;col=col+yyleng;}



[ \t] col=col+strlen(yytext);
\n {nb_ligne++;col=1;}
. { printf("erreur lexicale ligne %d colonne %d\n", nb_ligne,col) ; }

%%