#!/usr/bin/perl

use Data::Dumper;


my $infile = shift;
open(INFILE,$infile) or die #!;
open(OUTFILE,">outfile.html") or die $!;

my @HASHES;
while (<INFILE>) {
	chomp($_);
	my @line = split('\\\\',$_);
	#print Dumper(\@line);
	for (my $i=0;$i<(@line-1);$i++) {
		next if $line[$i] eq "S:";
		next if $line[$i] eq "WEB";
			
	}
}


