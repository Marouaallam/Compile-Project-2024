%{


int nb_ligne = 1;
int col = 1;
int valeur;



int Fin_if=0,deb_else=0,deb_for=0,fin_for=0,deb_while=0,fin_while=0;
  int val=0,val2=0;
  char tmp [20];
  int qc=0;

   char variablesMemeLigne[100][20];
   int countVariablesMemeLigne;
      char sauvType[25];
      float savedVal;


%}

%union {
    int entier;
    char caractere;
    char* string;
    float real;

}

%token MC_PROG MC_END MC_ROUTINE MC_ENDR MC_INTEGER MC_REAL MC_LOGICAL 
MC_CHARACTER MC_READ MC_WRITE MC_THEN MC_IF MC_ELSE MC_ENDIF MC_DOWHILE MC_ENDDO 
MC_CALL MC_EQUIVALENCE MC_DIMENSION MC_OR MC_AND MC_GT MC_GE MC_EQ MC_NE MC_LE 
MC_LT <string>idf <caractere>charr <entier>intt comment <real>real <string>string 
AFF PVG VG GUI DP PRR PRL  SOUSTRACTION ADDITION MULTIPLICATION DIVISION MC_TRUE 
MC_FALSE


%left ADDITION SOUSTRACTION
%left MULTIPLICATION DIVISION
%left MC_OR
%left MC_AND
%start S

%type<string> EXP;
%type<string> EXP1;
%type<string> EXP2;
%type<string> cst;
%type<string> VAR;
%type<string> EXP0;
%%
S: FUNC PROGRAM {
    printf("Syntax is correct.\n");
    YYACCEPT;
};

FUNC:
    FUNC type MC_ROUTINE idf PRL DECl PRR DEC INST MC_ENDR |
    ;
PROGRAM:
    MC_PROG idf DEC INST MC_END
    ;
INST:
  idf AFF EXP0 PVG INST {
		if(nonDeclare($1) != -1 && typeCompatibilite(getVarType($1), "=", $3) != -1)
			setVarVal($1, savedVal);
	}
  |idf PRL intt PRR EXP0 PVG INST {
		if(nonDeclare($1) != -1 && typeCompatibilite(getVarType($1), "=", $3) != -1)
			setVarVal($1, savedVal);
	}
  |idf PRL intt VG intt PRR  EXP0 PVG INST {
		if(nonDeclare($1) != -1 && typeCompatibilite(getVarType($1), "=", $3) != -1)
			setVarVal($1, savedVal);
	}
  | MC_READ PRL idf PRR PVG INST
  | MC_WRITE PRL WRI PRR PVG INST
  | INSTIF INST
  | DOWHILE INST 
  | MC_EQUIVALENCE listvar PVG 
  |
;
INSTIF:A ELSE{   if( val2==1  ){
                       val2=0;
					   sprintf(tmp,"%d",qc); 
                        ajour_quad(deb_else,1,tmp); 
                      quadr("vide", "","temp_else", "vide");
                      sprintf(tmp,"%d",qc); 
                      ajour_quad(Fin_if,1,tmp);					  }
                    else{  sprintf(tmp,"%d",qc); 
                      ajour_quad(Fin_if,1,tmp);}
				       printf("pgm juste");
}
;
A:B MC_THEN INST{ 
                                    quadr("vide", "","temp_if", "vide");  
				                    Fin_if=qc; 
                                    									
                                    quadr("BR", "","vide", "vide");   
				                    
								  
				   }
;
B:MC_IF EXPCOND {  deb_else=qc; 
 
                                       quadr("BZ", "","temp_cond", "vide"); 
                                                                   		
	}
;
ELSE :MC_ELSE INST MC_ENDIF{ val2=1;}
|MC_ENDIF
;
DOWHILE: AW INST MC_ENDDO {quadr("vide","","temp code", "vide");
                                            sprintf(tmp,"%d",deb_while);
                                            quadr("BR",tmp ,"vide", "vide");
											sprintf(tmp,"%d",qc);
                                            ajour_quad(fin_while,1,tmp);}
;

AW:BW  EXPCOND { fin_while=qc;
                         quadr("BNZ","","cond.temp", "");

}
;
BW: MC_DOWHILE {deb_while=qc;}
;
;
VAR: idf{ if(nonDeclare($1) != -1){
			$$ = getVarType($1);
	}
	}
| idf PRL X PRR{ if(nonDeclare($1) != -1){
			$$ = getVarType($1);
		}
	}
| idf PRL X VG X PRR{ if(nonDeclare($1) != -1){
			$$ = getVarType($1);
	}
	}
;
listvar:
    PRL VAR VG listvar2 PRR VG listvar
    | PRL VAR VG listvar2 PRR 
;
listvar2:VAR VG listvar2
    |VAR
;
EXPCOND:
    EXPCOND MC_AND EXPCOND1 
    |EXPCOND1
    ;
     
EXPCOND1:
     EXPCOND1 MC_OR EXPCOND2
     |EXPCOND2 
;
EXPCOND2:
     PRL EXPCOND PRR
     |EXP comp EXP 
     |EXP compl BOOL  
;
comp: 
    MC_OR  
    | MC_AND 
    | MC_GT  
    | MC_GE  
    | MC_LE  
    | MC_LT  
;
compl:
    MC_EQ 
    | MC_NE 
;
WRI:
   string WRI
   |VG X VG WRI
   |VG X
   |

;
type:
     MC_INTEGER  { strcpy(sauvType, "int"); }
    |MC_REAL     { strcpy(sauvType, "real"); }
    |MC_CHARACTER { strcpy(sauvType, "char"); }
    |MC_LOGICAL   { strcpy(sauvType, "LOGICAL"); }
    ;
DEC: 
     
     type DECl PVG DEC
    | DIMENSION PVG DEC
    | MC_CHARACTER idf CHAR PVG DEC
    |   
    ;

DECl:
     idf VG DECl {if(doubleDeclaration($1)==0){inserer($1,"idf",sauvType,0,0);}};
    |idf {if(doubleDeclaration($1)==0){inserer($1,"idf",sauvType,0,0);}};
;
DIMENSION:type idf MC_DIMENSION PRL intt PRR 
        {if(doubleDeclaration($2)==0) { 
if($5>0){ inserer($2,"idf",sauvType,$5,0);
         }
else{ printf("Erreur semantique: la taille de tableau %d doit etre positive a la ligne %d a la colonne %d\n ",$5,nb_ligne, col);}
}}  
    |type idf MC_DIMENSION PRL intt VG intt PRR PVG
                {if(doubleDeclaration($2)==0) { 
if($5>0 || $7>0){ inserer($2,"idf",sauvType,$5,0);inserer($2,"idf",sauvType,$7,0);}
else{ printf("Erreur semantique: la taille du matrice %d %d doit etre positive a la ligne %d a la colonne %d\n ",$5,$7,nb_ligne, col);}
}}
;
X: VAR
  |cst
;   
cst: intt{ 
         valeur=$1;
		 $$ = "int";
         savedVal=$1;
	 }
    | real{
         valeur=$1;
		 $$ = "real";
         savedVal=$1;}
         
    | charr { $$="string"; }
    | string{ $$="string"; }
;
CHAR:MULTIPLICATION cst
    |DIMENSION
; 
EXP0:
     EXP
     |BOOL
     |string
     |idf PRL intt PRR PVG{ if(nonDeclare($1) != -1){
			$$ = getVarType($1);
	}
	 }
     |MC_CALL idf PRL DECl PRR PVG
;
EXP:
    EXP1
    | EXP MULTIPLICATION EXP1 {
        $$ = $1;
	   typeCompatibilite($1,"*",$3);
   }
    | EXP DIVISION EXP1 {
        $$ = $1;
	   typeCompatibilite($1,"/",$3);
                           if( valeur==0 ) { 

						   printf("\n ******erreur semantique : division par 0 ********* \n");}
                         }
    ;
EXP1:
     EXP2 
    | EXP1 ADDITION EXP2{
        $$ = $1;
	   typeCompatibilite($1,"+",$3);
   }
     
    | EXP1 SOUSTRACTION EXP2{
        $$ = $1;
	   typeCompatibilite($1,"-",$3);
   }
    ;
EXP2:
      VAR
    | PRL EXP PRR
    | cst 
    ;
BOOL:MC_FALSE
| MC_TRUE
; 


%%

int main() {
    initialisation();
    yyparse();
    afficher();
    afficher_qdr();
}

yywrap() {}

int yyerror(char* msg) {
    printf("Syntax error at line %d, column %d: %s\n", nb_ligne, col);
}
