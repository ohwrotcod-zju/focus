
#include <common.h>


char  *  cgetline(FILE *imgcfg, char *strchar)
{          
	char *st,  *st1,  *st4, *st5, *st6, *pch;

	st=(char *)calloc(200,sizeof(char));
	st1=(char *)calloc(200,sizeof(char));

	st4=(char *)calloc(200,sizeof(char));
	st5=(char *)calloc(200,sizeof(char));
	st6=(char *)calloc(200,sizeof(char));



	fgets(st,200,imgcfg);


	if(feof(imgcfg)==0)
	{  
		strcpy(st4,"");
		strncat(st4,st,3);

		strcpy(st1,"");
		strncat(st1,st+4,115);

		while(feof(imgcfg)==0 && ( strncmp(st4,"set",3)!=0 ||  strncmp(st1, strchar,strlen(strchar))!=0))
		{
			fgets(st,200,imgcfg);
			strcpy(st4,"");
			strncat(st4,st,3);

			strcpy(st1,"");
			strncat(st1,st+4,115);
		}

		if(feof(imgcfg)==0 && strncmp(st1, strchar,strlen(strchar))==0)
		{ 
			pch=(char *)memchr(st, '"', 180);   
			strcpy(st5,pch+1);

			pch=(char *)memchr(st5,'"',200);
			strcpy(st6,"");
			strncat(st6,st5, strlen(st5)-strlen(pch));

			rewind(imgcfg);   return(st6);
		}     
		else {  printf(" '%s' string parameter does not exist in 2dx_image.cfg \n",strchar);   rewind(imgcfg);   return(NULL);  }                

	}
	else
	{  printf(" ' %s' string strparameter does not exist  in 2dx_image.cfg\n",strchar);  rewind(imgcfg);  return(NULL);       }

	free(st);
	free(st1);
	free(st4);
	free(st5);
	free(st6);  


}
