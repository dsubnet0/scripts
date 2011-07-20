#!/usr/bin/perl -w

use Data::Dumper;
use strict;

my %RESULTHASH;

foreach my $currFile (@ARGV) {
	#my %COUNTPERWORD = ();
	open(INFILE,$currFile);
	
	while (<INFILE>) {
		chomp();
		my $line = $_;
		$line =~ tr/[A-Z]/[a-z]/; 
		$line =~ s/[\,\.!?\-"]/\t/g; 
		my @line = split(' ',$line);
		foreach my $currWord (@line) {
			if ($RESULTHASH{$currFile}{$currWord}) {
				$RESULTHASH{$currFile}{$currWord}++;
			} else { 
				$RESULTHASH{$currFile}{$currWord} = 1;
			}
		}	
	}

	#print "\n\n\n$currFile:\n\n";
	#print Dumper(\%COUNTPERWORD);
}

#print Dumper(\%RESULTHASH);
my @master_word_list;
foreach my $currFile (sort keys %RESULTHASH) {
	@master_word_list = sort (@master_word_list, (keys %{$RESULTHASH{$currFile}}));

}

#print Dumper(\@master_word_list);

#remove dups
my %duptemp = map {$_,1} @master_word_list;
@master_word_list = sort keys %duptemp;

print "WORD";
print ",$_" foreach (sort keys %RESULTHASH);
print "\n";

foreach my $currWord (@master_word_list) {
	print "$currWord";
	foreach my $currFile (sort keys %RESULTHASH) {
		if ($RESULTHASH{$currFile}{$currWord}) {
			print ",$RESULTHASH{$currFile}{$currWord}";
		} else {
			print ",0";
		}
	}
	print "\n";
}
