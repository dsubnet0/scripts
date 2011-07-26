#!/usr/bin/perl

use Data::Dumper;
$|=1;
my @fileList = </cygdrive/d/logs/wh/*>;

my %VISITS_PER_DATE;
my $running_count = 0;

foreach my $currFile (sort @fileList) {
	print "\n$running_count found so far...\n";
	print Dumper(\%VISITS_PER_DATE);
	print "Processing $currFile...\n";

	open (INFILE,$currFile) or die "cannot open $currFile: $!";

	while (my $line = <INFILE>) {
		my ($host,$datetime,$url_with_method,$status,$size,$referrer,$agent) = $line =~ m/^(\S+) - - \[(\S+ [\-|\+]\d{4})\] "(\S+ \S+ [^"]+)" (\d{3}) (\d+|-) "(.*?)" "([^"]+)"$/;
	
		#print "\rcount = $running_count   currTime = $datetime";
	
		my @datetime = split(':',$datetime);
		my $date = $datetime[0];
	
		if ($url_with_method =~ m/GET \/ebooks\/helphandbook.php /i &&
			$agent !~ m/GomezAgent/i) {
			$running_count++;
			$VISITS_PER_DATE{$date}++;
		}
	}
}

#print "\n".Dumper(\%VISITS_PER_DATE);
foreach (sort keys %VISITS_PER_DATE){
        print "$_,$VISITS_PER_DATE{$_}\n";
}

print "TOTAL = $running_count\n";


