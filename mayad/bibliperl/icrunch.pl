#!/usr/bin/env perl
use strict;
use warnings;
use diagnostics;

print "Nombre de caractère minimum :";
my$nbm=<>;chomp$nbm;
print "Nombre de caractère maximum :";
my$nbh=<>;chomp$nbh;
print "Mix de caractères qui sera mélangés :";
my$mix=<>;chomp$mix;
print "Fichier de sortie :";
my$filename=<>;chomp$filename;
my$cmd="crunch $nbm $nbh $mix";
if ($filename ne "")
{
	$cmd.=" > ./out/wordlists/$filename";
}
print "Ligne de commande : $cmd \n";
print "...Lancement de Crunch...\n";
system "$cmd";
