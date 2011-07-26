#!/usr/bin/perl

use Data::Dumper;

my $infile = shift;
open(INFILE,$infile) or die $!;

my %HASH;
my $i=0;
my $start,$len;
while (<INFILE>) {
	print "iteration ".++$i."\n";
	chomp();
	my @line = split('\|');
	##push(@{$HASH{$line[0]}},substr($line[1],0,30)) if (InArray(substr($line[1],0,30),\@{$HASH{$line[0]}}) < 0);

	my @hit_locations = FindNameInArray($line[1]);
	foreach my $currLoc (@hit_locations) {
		if (($currLoc - 10) <= 0) {
			$start = 0;	
		} else {
			$start = $currLoc - 10;
		}

		if (($currLoc + 20) >= (length($line[1]) - 1)) {
			$len = (length($line[1]) - 1 - $currLoc);
		} else {
			$len = 20;
		}

		print "Found hit at $currLoc.  Starting from $start for $len places.\n";
		push(@{$HASH{$line[0]}},substr($line[1],$start,$len));
	}


	last if $i==100;
}

print Dumper(\%HASH);

sub InArray {
	my ($string,@array) = @_;

	for (my $i=0;$i<@array;$i++) {
		if ($array[$i] eq $string) {
			return $i;
		}
	}
	return -1;
}


sub FindNameInArray {
	my $string = shift;
	my @locations = ();

	my @targets = split("\|","(webuser|macindia|perception|perception4|qmarkuser|arga2|gbuser|bbib|hclwebops|iclicker_back|iclicker|iclicker_gb_sync|poladmin|virtualit|webclicker|deployadmin|DTSUsers|QPCAdmin|QPCUser)");

	foreach my $currTarget (@targets) {
		my $location = index($string,$currTarget);
		if ($location > 0) {
			push(@locations,$location);
		}	
	}
	return @locations;
}
