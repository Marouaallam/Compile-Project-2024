#include <string.h>
#include <stdio.h>
#include <stdlib.h>
typedef struct qdr{

    char operande[100]; 
    char op1[100];   
    char op2[100];   
    char resultat[100];  
    
  }qdr;
  qdr quad[1000];
extern int qc;




void quadr(char operande[],char op1[],char op2[],char resultat[])
{

	strcpy(quad[qc].operande,operande);
	strcpy(quad[qc].op1,op1);
	strcpy(quad[qc].op2,op2);
	strcpy(quad[qc].resultat,resultat);
	
	
qc++;

}

void ajour_quad(int num_quad, int colon_quad, char valeur [])
{
if (colon_quad==0) strcpy(quad[num_quad].operande,valeur);
else if (colon_quad==1) strcpy(quad[num_quad].op1,valeur);
         else if (colon_quad==2) strcpy(quad[num_quad].op2,valeur);
                   else if (colon_quad==3) strcpy(quad[num_quad].resultat,valeur);

}

void afficher_qdr()
{
printf("-------Quadruplets---------\n");

int i;

for(i=0;i<qc;i++)
		{

 printf("\n %d - ( %s  ,  %s  ,  %s  ,  %s )",i,quad[i].operande,quad[i].op1,quad[i].op2,quad[i].resultat); 
 printf("\n--------------------------------------------------------\n");

}
}

