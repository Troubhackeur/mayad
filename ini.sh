#!/bin/bash
# version 0.1
clear;

### setup
name="Mayad"
requestfile="tmp/req.tmp"
wctmp="tmp/wc.tmp"
wclsprog="tmp/wclsprog.tmp"
lsprog="tmp/lsprog.tmp"
lsfunc="tmp/lsfunc.tmp"
wclsfunc="tmp/wclsfunc.tmp"
lslangprog="tmp/lslangprog.tmp"
wclslangprog="tmp/wclslangprog.tmp"


### title
echo " --------------------------- ${name} ------------------------------ "
### comptage de  languages de prod
ls -1 db/ > ${lsprog} ;
wc -w ${lsprog} | cut -d " " -f 1 > ${wclsprog} ;
wcls=`cat ${wclsprog}` ;

### comptage des fonctions connues
ls -1 functions/ > ${lsfunc} ;  
wc -w ${lsfunc} | cut -d " " -f 1 > ${wclsfunc} ;
wclsfunc=`cat ${wclsfunc}` ;

### Bienvenue ###
echo "type \"help\" to ask help...";
################# BOUCLE DU RUN  ################################
while true ; do
	 a=0
	 i=0
	 k=0

	 echo "";
	 echo -n "@$name <{ ";read rep ##### INPUT
	 echo $rep > $requestfile ;

	 ### comptage de mots
	 wc -w $requestfile | cut -d " " -f 1 > $wctmp ;
	 wc=`cat $wctmp` ;	
	 ### boucle : pour chaque mot de la requete, 
	 while [ $i -lt $wc ] ; do  
	     i=$(($i + 1));
	     word=`cut -d " " -f $i $requestfile`;
	     j=0;
     	 ### boucle : pour chaque languages de prog
		 while [ $j -lt $wcls ] ; do 
		 	 j=$(($j + 1));
		 	 lprog=`sed -n ${j}p $lsprog`;
		 	 ### Si : un mot correspond à un language de prog,
		     if [ $word = $lprog ] ; then
		  	     langpath="db/"`echo ${lprog}`;
			     ls -1 `echo ${langpath}` > $lslangprog ;	
			     wc -w ${lslangprog} | cut -d " " -f 1 > ${wclslangprog} ;
			     wclsprog=`cat ${wclslangprog}` ;
			     m=0;
			     ### boucle : pour chaque memo dans le dossier du language de prog
			     while [ $m -lt $wclsprog ] ; do
				     m=$(($m + 1));
	    	         memo=`sed -n ${m}p $lslangprog`;
				     n=0;
				     ### boucle : pour chaque mot de la requete de base
		 	         while [ $n -lt $wc ] ; do
				    	 n=$(($n + 1));
 				         ward=`cut -d " " -f $n $requestfile`;
				    	 ### Si : un mot de la requete correspong à un memo,
				    	 if [ $memo = $ward ] ; then
				    		 pathtxt=`echo ${langpath}`"/"`echo $memo`;
				    		 clear;
					    	 echo " --------------------------- ${name} ------------------------------ ";
					    	 cat $pathtxt;
					    	 a=1;
					     fi
				    done 
			     done	    
			 while [ $o -lt $wclsfunc ] ; do
	    	 	 o=$(($o + 1));
	    		 func=`sed -n ${o}p $lsfunc`;
	    	 if [ $word = $func ] ; then
	    	     ./functions/`echo ${func}`
	    		 break;
	    	 fi
    	 done
			     if [ $a = 0 ] ; then
					 clear;
			    	 echo " --------------------------- ${name} ------------------------------ ";
			    	 echo "number of memos about" ${lprog}" : " ${wclsprog} ;
			    	 cat ${lslangprog} ;
		     	 fi
		    	 #break;
		     fi
		 done
	     o=0
	     #### Appel des functions si jamais ....	
	     while [ $o -lt $wclsfunc ] ; do
	    	 o=$(($o + 1));
	    	 func=`sed -n ${o}p $lsfunc`;
	    	 if [ $word = $func ] ; then
	    	     ./functions/`echo ${func}`
	    		 break;
	    	 fi
    	 done
     done
done
