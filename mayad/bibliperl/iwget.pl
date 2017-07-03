#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

my $ldc = "wget";

# ---- cible 
print "...Module WGET interactif...\n";
print "Voulez-vous passer en arrière plan après le démarrage ? (o/n)\n";
print "> "; my$rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o"|| $rep eq "O")
{
	$ldc .= " -b";
	print "Construction de la commande: $ldc\n";		

}
# ---- mode verbeux
print "Voulez-vous un mode verbeux ? (o/n)\n";
print "> "; $rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "n" || $rep eq "N")
{
	$ldc .= " -nv";
	print "Construction de la commande: $ldc\n";		

}

# ---- user
print "Voulez-vous définir un identifiant ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	my$user="";
	while ($user eq "")
	{
		print "user :\n";		
		$user=<>;chomp$user;
	}
	$ldc = $ldc ." --user=".$user;
	print "Construction de la commande: $ldc\n";	
}

# ---- password
print "Voulez-vous définir un password ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	my$password="";
	while ($password eq "")
	{
		print "password :\n";		
		$password=<>;chomp$password;
	}
	$ldc = $ldc ." --password=".$password;
	print "Construction de la commande: $ldc\n";	
}
# ---- user-agent
print "Voulez-vous définir un user-agent plutôt que Wget/version ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	my$uagent="";
	while ($uagent eq "")
	{
		print "user-agent :\n";		
		$uagent=<>;chomp$uagent;
	}
	$ldc = $ldc ." --user-agent=".$uagent;
	print "Construction de la commande: $ldc\n";	
}

# ---- téléchargement récursif
print "Voulez-vous un téléchargement récursif ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o" || $rep eq "O")
{
	$ldc .= " -r";
	print "Construction de la commande: $ldc\n";
	
	# ---- niveau de récursion
	print "Quel niveau de récursion maximal ? (0=infini)\n";
	print "> ";$rep=<>;
	chomp $rep;
	if ($rep ne "")
	{
		$ldc .= " --level=".$rep;
		print "Construction de la commande: $ldc\n";		
	
	}	
}

# ---- acceptation d'extension

print "Voulez-vous télécharger uniquement certaines extensions ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	my$liste="";
	while ($liste eq "")
	{
		print "Liste d'extensions acceptées, séparées par des virgules :\n";		
		$liste=<>;chomp$liste;
	}
	$ldc = $ldc ." --accept=". $liste;
	print "Construction de la commande: $ldc\n";
}

# ---- rejet d'extension

print "Voulez-vous rejeter certaines extensions ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	my$liste="";
	while ($liste eq "")
	{
		print "Liste d'extensions rejetées, séparées par des virgules :\n";		
		$liste=<>;chomp$liste;
	}
	$ldc = $ldc ." --reject=". $liste;
	print "Construction de la commande: $ldc\n";
}

# ---- suivre les liens ftp
print "Voulez-vous suivre les liens FTP ? (o/n)\n";
print "> "; $rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o" || $rep eq "O")
{
	$ldc .= " --follow-ftp";
	print "Construction de la commande: $ldc\n";		

}
# ---- suivre les liens externes
print "Voulez-vous suivre les liens externes en mode récursif ? (o/n)\n";
print "> "; $rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o" || $rep eq "O")
{
	$ldc .= " --span-host";
	print "Construction de la commande: $ldc\n";		

}
# ---- suivre les liens relatifs
print "Voulez-vous suivre uniquement les liens relatifs ? (o/n)\n";
print "> "; $rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o" || $rep eq "O")
{
	$ldc .= " -L";
	print "Construction de la commande: $ldc\n";		

}
# ---- no parent
print "Voulez-vous remonter le répertoire parent ? (o/n)\n";
print "> "; $rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "n" || $rep eq "N")
{
	$ldc .= " -np";
	print "Construction de la commande: $ldc\n";		

}
# ---- cible

print "Quel sera votre URL cible ?\n";
print "> "; my $cible=<>;
chomp $cible;
if ($cible ne "")
{
	$ldc .= " ".$cible;
	print "Construction de la commande: $ldc\n";	
}
else
{
	print "> "; my $cible=<>;
	chomp $cible;	
}

# ---- Config fichier de sortie

print "Voulez-vous enregistrer la sortie dans un fichier ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	my$filename="";
	while ($filename eq "")
	{
		print "Nom du fichier :\n";		
		$filename=<>;chomp$filename;
	}
	$ldc = $ldc ." > wget/". $filename;
	print "La sortie sera : arsenal/wget/$filename\n";
}


# ---- Confirmation
print "Voici la ligne de commande : $ldc\n";
print "En attente de confirmation (o/n) :\n";
$rep="";
while($rep eq "")
{
	print "> ";$rep=<>;
	chomp $rep;
	if ($rep eq "o" || $rep eq "O")
	{
		print "... Lancement de wget...\n\n";
		system "$ldc";
	}
	elsif ($rep eq "N" || $rep eq "n")
	{
		print "... Annulé...\n";
		system "./ini.pl";
	}
	else
	{
		$rep="";
	}
}
