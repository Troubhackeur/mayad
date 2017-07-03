#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

my $ldc = "medusa ";

# ---- cible 
print "...Module Medusa interactif...\n";
print "Voulez-vous indiquer plusieurs cibles à l'aide d'un fichier ? (o/n)\n";
print "> "; my$rep=<>;chomp$rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "n" || $rep eq "N")
{
	print "Quel sera votre cible ? (vide = localhost)\nVous pouvez attaquer une plage IP, par exemple 192.168.0-255.0-255.\n";
	print "> "; my $cible=<>;
	chomp $cible;
	if ($cible eq "")
	{
		$cible="-h 127.0.0.1 ";
		$ldc .= $cible;
		print "Construction de la commande: $ldc\n";	
	}
	else
	{
		$ldc .= "-h ".$cible;
		print "Construction de la commande: $ldc\n";		
	}
}
elsif ($rep eq "o" || $rep eq "O")
{
	print "Ou se situe le fichier ?\n";
	my$targetlist=<>;chomp$targetlist;
	$ldc .= "-H ".$targetlist;
	print "Construction de la commande: $ldc\n";		

}
# ----  username
$rep="";
print "Voulez-vous indiquer plusieurs nom d'utilisateurs à l'aide d'un fichier ? (o/n)\n";
print "> "; $rep=<>;chomp $rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "n" || $rep eq "N")
{
	print "Quel sera le nom d'utilisateur ?\n";
	print "> "; my $username=<>;
	chomp $username;
	$ldc .= " -u $username";
	print "Construction de la commande: $ldc\n";
}
elsif ($rep eq "o" || $rep eq "O")
{
	print "Ou se situe le fichier ?\n";
	my$userlist=<>;chomp$userlist;
	$ldc .= "-U ".$userlist;
	print "Construction de la commande: $ldc\n";		
}
# ----  password
print "Voulez-vous indiquer plusieurs mots de passe à l'aide d'un fichier ? (o/n)\n";
print "> "; $rep=<>;chomp $rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "n" || $rep eq "N")
{
	print "Quel sera le mot de passe ?\n";
	print "> "; my $password=<>;chomp $password;
	$ldc .= " -p $password";
	print "Construction de la commande: $ldc\n";	
}
elsif ($rep eq "o" || $rep eq "O")
{
	print "Ou se situe le fichier ?\n";
	my$passlist=<>;chomp$passlist;
	$ldc .= " -P ".$passlist;
	print "Construction de la commande: $ldc\n";		
}

# ----  modules
print "Affichage des Modules... Lancement de Medusa...";
system "medusa -d";
print "Quel module voulez-vous utiliser ( sans l'extension .mod )?\n";
print "> "; $rep=<>;chomp $rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
$ldc .= " -M ".$rep;
print "Construction de la commande: $ldc\n";		

# ---- non default port
print "Voulez-vous viser un port non conventionnel ? Si non, laisser vide. \n";
print "> "; $rep=<>;chomp $rep;
if ($rep ne "")
{
	$ldc .= " -n $rep";
	print "Construction de la commande: $ldc\n";	
}

# ----  Additional password check
print "Vérification supplémentaires :\n";
print "Voulez-vous essayer avec un mot de passe vide (o/n)?\n";
print "> "; $rep=<>;chomp $rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o" || $rep eq "O")
{
	print "Voulez-vous essayer avec nom d'utilisateur équivalent au mot de passe (o/n)?\n";
	while ($rep eq "")
	{
		$rep=<>;chomp$rep;
	}
	if ($rep eq "o" || $rep eq "O")
	{	
	$ldc .= " -e ns";
	print "Construction de la commande: $ldc\n";		
	}
	else
	{
	$ldc .= " -e n";
	print "Construction de la commande: $ldc\n";
	}
}
else
{
	print "Voulez-vous essayer avec nom d'utilisateur équivalent au mot de passe (o/n)?\n";
	while ($rep eq "")
	{
		$rep=<>;chomp$rep;
	}
	if ($rep eq "o" || $rep eq "O")
	{	
	$ldc .= " -e s";
	print "Construction de la commande: $ldc\n";		
	}
}
# ----  SSL mode
print "Voulez-vous activer le mode SSL ? (o/n)\n";
print "> "; $rep=<>;chomp $rep;
while ($rep eq "")
{
	$rep=<>;chomp$rep;
}
if ($rep eq "o" || $rep eq "O")
{
	$ldc .= " -s";
	print "Construction de la commande: $ldc\n";	
}
# ----  sleeping time
print "Combien de seconde attendre entre chaque essai (3 par défaut)?\n";
print "> "; $rep=<>;chomp $rep;
if ($rep ne "")
{
	$ldc .= " -r $rep";
	print "Construction de la commande: $ldc\n";	
}

# ---- stop when found
print "Voulez-vous arrêter les tests au premier test valide ? (o/n)\n";
print "> "; $rep=<>;chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	$ldc .= " -F";
	print "Construction de la commande: $ldc\n";	
}
# ---- Config fichier de sortie

print "Voulez-vous enregistrer la sortie dans un fichier (o/n)?\n";
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
	$ldc = $ldc ." > ./out/medusa/". $filename;
	print "La sortie sera : out/medusa/$filename\n";
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
		print "... Lancement de Medusa...\n\n";
		system "$ldc -b";
	}
	elsif ($rep eq "n" || $rep eq "N")
	{
		print "... Annulé...\n";
		system "./ini.pl";
	}
	else
	{
		$rep="";
	}
}
