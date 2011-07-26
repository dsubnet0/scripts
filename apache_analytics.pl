#!/usr/bin/perl

use Data::Dumper;
$|=1;

open (INFILE,"/cygdrive/d/logs/wh/hh-combined_wh2.log") or die "cannot open log";

my %VISITS_PER_DATE;
my $line_counter = 0;
while (my $line = <INFILE>) {
	#print Dumper(\%VISITS_PER_DATE);
	my ($host,$datetime,$url_with_method,$status,$size,$referrer,$agent) = $line =~ m/^(\S+) - - \[(\S+ [\-|\+]\d{4})\] "(\S+ \S+ [^"]+)" (\d{3}) (\d+|-) "(.*?)" "([^"]+)"$/;

	print "\rcount = $line_counter   currTime = $datetime";

	my @datetime = split(':',$datetime);
	my $date = $datetime[0];

	if ($url_with_method =~ m/GET \/ebooks\/helphandbook.php /i &&
		$agent !~ m/GomezAgent/i) {
		#print "$date: $url_with_method\n $agent\n\n";
		$VISITS_PER_DATE{$date}++;
		$line_counter++;
	}
}

print "\n".Dumper(\%VISITS_PER_DATE);
