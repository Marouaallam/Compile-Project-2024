/****************CREATION DE LA TABLE DES SYMBOLES ******************/
/***Step 1: Definition des structures de donnees ***/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
extern int nb_ligne, col;
typedef  struct cst_var *Liste ;
typedef struct cst_var /*Table de symboles des csts et var*/
{
   char name[20];
   char code[20];
   char type[20];
   float val; /* data */
   Liste svt;
}  cst_var_element;
typedef  struct sep_mc *Liste1 ;
typedef struct sep_mc /*Table des symboles des separateurs et mots cles*/
{
   char name[20];
   char type[20]; /* data */
   Liste1 svt;
}   sep_mc_elt;

    Liste prd;
    Liste1 prd11,prd12;


Liste tete=NULL;
Liste1 tete1=NULL;
Liste1 tete2=NULL;
extern char sav[20];

void initialisation()
{
    tete=NULL;
    tete1=NULL;
    tete2=NULL;
}

/***Step 2: insertion des entititées lexicales dans les tables des symboles ***/

void ajout_apres(Liste *tete, Liste *prd, char entite[], char code[], char type[], float val) {
    Liste nouv = (Liste)malloc(sizeof(cst_var_element));
    nouv->svt = *tete;
    strcpy(nouv->name, entite);
    strcpy(nouv->code, code);
    strcpy(nouv->type, type);
    nouv->val = val;
    nouv->svt = NULL;

    if (*tete == NULL) {
        *tete = nouv;
    } else {
        (*prd)->svt = nouv;
    }

    *prd = nouv;
}

void ajout_apres1(Liste1 *tete, Liste1 *prd, char entite[], char type[]) {
    Liste1 nouv = (Liste1)malloc(sizeof(sep_mc_elt));
    nouv->svt = *tete;
    strcpy(nouv->name, entite);
    strcpy(nouv->type, type);
    nouv->svt = NULL;

    if (*tete == NULL) {
        *tete = nouv;
    } else {
        (*prd)->svt = nouv;
    }

    *prd = nouv;
}

int exists(Liste tete,char entite[]){
    int f;
    Liste p;
    p=tete;
    while(p!=NULL&&(strcmp(entite,p->name)!=0)){
        p=p->svt;
        }
    if(p==NULL)
        f=0;
    else f=1;
    return f;
    }
char *getVarCode(char* entite){
    
     Liste p;
    p=tete;
    while(p!=NULL&&(strcmp(entite,p->name)!=0)){
        p=p->svt;
        }
    
    return p->code;
}

char *getVarType(char* entite){
	Liste p;
    p=tete;
    while(p!=NULL&&(strcmp(entite,p->name)!=0)){
        p=p->svt;
        }
    return p->type;
}
float getVarVal(char* entite){
  char string [20];
	Liste p;
    p=tete;
    while(p!=NULL&&(strcmp(entite,p->name)!=0)){
        p=p->svt;
        }
    return p->val;
}
void setVarVal(char* entite, float val){
	Liste p;
    p=tete;
    while(p!=NULL&&(strcmp(entite,p->name)!=0)){
        p=p->svt;
        }
  p->val=val;
}

int doubleDeclaration(char* entite){
  if(exists(tete,entite) == 1){
    printf("Erreur Semantique, ligne %d, colonne %d : entite '%s' deja declare\n", nb_ligne, col, entite);
    return -1;
  }
  else return 0;
}

int nonDeclare(char* entite){
  if (exists(tete,entite)==0){
    printf("Erreur Semantique, ligne %d, colonne %d : entite '%s' non declare\n", nb_ligne, col, entite);
    return -1;
  }else{
    return 0;
  }
}
int typeCompatibilite(char type1[20], char op[20], char type2[20]){
  if(strcmp(type1, type2) != 0){
    printf("Erreur Semantique, ligne %d, colonne %d : incompatibalite de type %s %s %s\n", nb_ligne, col, type1, op, type2);
    return -1;
  }
  else return 0;
}

int exists1(Liste1 tete,char entite[]){
    int f;
    Liste1 p;
    p=tete;
    while(p!=NULL&&(strcmp(entite,p->name)!=0)){
        p=p->svt;
        }
    if(p==NULL)
        f=0;
    else f=1;
    return f;
    }

void inserer (char entite[], char code[],char type[],float val,int y)
{
  switch (y)
 {
   case 0:/*insertion dans la table des IDF et CONST*/

        ajout_apres(&tete,&prd,entite,code,type,val);

	   break;

   case 1:/*insertion dans la table des mots clés*/

        ajout_apres1(&tete1,&prd11,entite,code);

       break;

   case 2:/*insertion dans la table des séparateurs*/

      ajout_apres1(&tete2,&prd12,entite,code);

      break;
 }

}

/***Step 3: La fonction Rechercher permet de verifier  si l'entité existe dèja dans la table des symboles */
void rechercher (char entite[], char code[],char type[],float val,int y)
{

int j,i;

switch(y)
  {
   case 0:/*verifier si la case dans la tables des IDF et CONST est libre*/
        if(exists(tete,entite)==0)
        {

			inserer(entite,code,type,val,0);

         }
        else
          printf("entité existe déjà\n");
        break;

   case 1:/*verifier si la case dans la tables des mots clés est libre*/

        if(exists1(tete1,entite)==0)
          inserer(entite,code,type,val,1);
        else
          printf("entité existe déjà\n");
        break;

   case 2:/*verifier si la case dans la tables des séparateurs est libre*/
        if(exists1(tete2,entite)==0)
         inserer(entite,code,type,val,2);
        else
   	       printf("entité existe déjà\n");
        break;

  }

}
/***Step 4  L'affichage du contenue de la table des symboles ***/
void afficher()
{Liste p;
Liste1 q;

printf("/***************Table des symboles IDF*************/\n");
printf("____________________________________________________________________\n");
printf("\t| Nom_Entite |  Code_Entite | Type_Entite | Val_Entite\n");
printf("____________________________________________________________________\n");

p=tete;
while(p!=NULL){
    printf("\t|%10s |%15s | %12s | %12f\n",p->name,p->code,p->type,p->val);
    p=p->svt;
    }



printf("\n/***************Table des symboles mots clés*************/\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
q=tete1;
while(q!=NULL)
      {
        printf("\t|%10s |%12s | \n",q->name,q->type);
        q=q->svt;
      }

printf("\n/***************Table des symboles séparateurs*************/\n");

printf("_____________________________________\n");
printf("\t| NomEntite |  CodeEntite | \n");
printf("_____________________________________\n");
q=tete2;
while(q!=NULL)
      {
        printf("\t|%10s |%12s | \n",q->name,q->type);
        q=q->svt;
      }

}
