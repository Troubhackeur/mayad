#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

my $ldc = "nmap ";

# ---- calcul cible 
print "...Module Nmap interactif...\n";
print "Quel sera votre cible ? (vide = localhost)\nVous pouvez scanner une plage IP, par exemple 192.168.0-255.0-255.\n";
print "> "; my $cible=<>;
chomp $cible;
if ($cible eq "")
{
	$cible="localhost";
	$ldc .= $cible;
	print "Construction de la commande: $ldc\n";	
}
else
{
	$ldc .= $cible;
	print "Construction de la commande: $ldc\n";		
}

# ---- mode verbeux

print "Voulez-vous un retour verbeux ? (o/n)\n";
print "> "; my $rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	$ldc = $ldc ." -v";
	print "Construction de la commande: $ldc\n";
}

# ---- ports
print "Quelle plage de port doit-être scannée ? format 1-1000 (laisser vide pour tout scanner.)\n";
print "> ";my $ports=<>;
chomp $ports;
if ($ports eq "")
{
	$ports="1-65535";
	$ldc = $ldc ." -p $ports";
	print "Construction de la commande: $ldc\n";	
}
else {
	$ldc = $ldc ." -p $ports";
	print "Construction de la commande: $ldc\n";	
}
# ---- config IPv6
print "Voulez-vous activer l'IPv6 ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	$ldc = $ldc ." -6";
	print "Construction de la commande: $ldc\n";	
}
# ---- vitesse du scan
print "Quelle devra être la vitesse du test ? \n>> 0 - paranoid ; \n>> 1 - sneaky ; \n>> 2 - polite ; \n>> 3 - normal ; \n>> 4 - agressive ; \n>> 5 - insane ; \n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "")
{
	$ldc = $ldc ." -T3";
	print "Construction de la commande: $ldc\n";	
}
else{
	$ldc = $ldc ." -T$rep";
	print "Construction de la commande: $ldc\n\n";	
}
	
# ---- délai
print "Voulez-vous ajouter un délai en ms? \n>>(Sinon Nmap essayera d'agir au mieux en s'adaptant)\n";
print "> ";$rep =<>;
chomp $rep;
if ($rep eq "")
{
	print "Construction de la commande: $ldc\n";
}
else {
	$ldc = $ldc ." --scan-delay $rep"."ms";
	print "Construction de la commande: $ldc\n";
}

# ---- test des versions
print ">>Voulez-vous tester les ports ouverts pour déterminer le service en écoute et sa version ? (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	$ldc = $ldc ." -sV";
	print "Construction de la commande: $ldc\n";
	print "Voulez vous un test complet ? (non correspond à limiter le test aux plus probables pour une identification rapide) (o/n)\n";
	print "> ";$rep=<>;
	chomp $rep;
	if ($rep eq "o" || $rep eq "O")
	{
		$ldc = $ldc ." --version-all";
		print "Construction de la commande: $ldc\n";
	}
	elsif ($rep eq "n" || $rep eq "N")
	{
		$ldc = $ldc ." --version-light";
		print "Construction de la commande: $ldc\n";
	}
}
# ---- détectiond'OS
print "Voulez-vous activer le mode agressif ? (détection d'OS) (o/n)\n";
print "> ";$rep=<>;
chomp $rep;
if ($rep eq "o" || $rep eq "O")
{
	$ldc = $ldc ." -A";
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
	$ldc = $ldc ." > ./out/scans/". $filename;
	print "La sortie sera : out/scans/$filename\n";
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
		print "... Lancement de Nmap...\n\n";
		system "$ldc";
	}
	elsif ($rep eq "n" || $rep eq "N")
	{
		print "... Annulé...\n";
	}
	else
	{
		$rep="";
	}
}
