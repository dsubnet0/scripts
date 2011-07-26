#!/usr/bin/perl

use Data::Dumper;
open (INFILE,"/cygdrive/d/logs/hbbcs1a/ex101115.log") or die "cannot open log";

my %VISITS_PER_DATE;
my $line_counter = 0;
while (<INFILE>) {
	#next if ($line_counter < 4); 

	chomp();
	my @currLine = split(' ',$_);

	next if (@currLine != 14);

	#print "num fields = ".@currLine."\n";
	#if (@currLine != 14) {
	#	print "$line_counter has ".@currLine." fields\n";
	#}

	my $date = $currLine[0];
	my $time = $currLine[1];
	my $cs_method = $currLine[4];
	my $cs_uri_stem = $currLine[5];
	my $cs_uri_query = $currLine[6];
	my $cs_user_agent = $currLine[10];
	my $sc_status = $currLine[11];

	if ($cs_uri_stem =~ m/exercisecentral\/default.asp/i &&
		$cs_user_agent !~ m/gomez/i) {
		#print "".$date.$time.$cs_uri_stem."\n";
		$VISITS_PER_DATE{$date}++;
	}	

	$line_counter++;
}

print Dumper(\%VISITS_PER_DATE);
