#!/usr/bin/perl

use Data::Dumper;
$|=1;
my @fileList = </cygdrive/d/logs/HBBCS1A/*>;
push (@fileList,</cygdrive/d/logs/HBBCS1B/*>);

my %VISITS_PER_DATE;
my $running_count = 0;

foreach $currFile (@fileList) {
	print "$running_count found so far...\n";
	print Dumper(\%VISITS_PER_DATE);
	print "Processing $currFile...\n";
	open (INFILE,$currFile) or die "cannot open $currFile";
	my $line_counter = 0;

	while (<INFILE>) {
		chomp();
		my @currLine = split(' ',$_);
	
		next if (@currLine != 14);
	
		my $date = $currLine[0];
		my $time = $currLine[1];
		my $cs_method = $currLine[4];
		my $cs_uri_stem = $currLine[5];
		my $cs_uri_query = $currLine[6];
		my $cs_user_agent = $currLine[10];
		my $sc_status = $currLine[11];
	
		if ($cs_uri_stem =~ m/exercisecentral\/default.asp/i && 
			$cs_user_agent !~ m/gomez/i && $cs_method =~ m/GET/) {
			#print "".$date.$time.$cs_uri_stem."\n";
			$running_count++;
			$VISITS_PER_DATE{$date}++;
		}	
	
		$line_counter++;
	}
	#last;
}

#print Dumper(\%VISITS_PER_DATE);
foreach (sort keys %VISITS_PER_DATE){
	print "$_,$VISITS_PER_DATE{$_}\n";
}

print "TOTAL = $running_count\n";
