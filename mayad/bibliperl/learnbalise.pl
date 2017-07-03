#!/usr/bin/perl 
system("clear");
open(NAME,"tmp/newlang.tmp")
        || die("fail tmp/newlang.tmp: $!");
my $name = <NAME>;
chomp $name; 
print "Which type of language it is ?\n";
my $type = <>;
chomp $type; 
system"echo '$name' > db/$name/resume";
system"echo 'type : $type' >> db/$name/resume";
system"echo ' ' >> db/$name/resume";

print "Enter your memo and finish by 'XXX'. \n";


#system"pwd";
my$bool=1;
while ($bool == 1) {
	my$text=<>;
	chomp$text;
	if ($text eq "XXX")
	{
		$bool=0; # sortie de la boucle
		print "OK.";
		exit;
	}
	system"echo $text >> db/$name/resume"; 
}
