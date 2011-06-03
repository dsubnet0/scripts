#!/usr/bin/perl

use Data::Dumper;
use strict;

$| = 1;

my %HASH;

for (my $i=0; $i<20; $i++) {
	my $kidPid = fork();
	my $localtime1 = localtime(time);

	if ($kidPid) { # I'm the parent
		#print "process $kidPid launched at  $localtime1...\n";
		push(@{$HASH{$kidPid}},$localtime1);	
	} else {
		sleep 2;
		my $localtime2 = localtime(time);
		#print "I'M CHILD $$.  WAITED 2.  TIME IS $localtime2.  EXITING NOW.\n";
		push(@{$HASH{$kidPid}},$localtime2);	
		exit();
	}

	print "ending iteration $i...\n";
	sleep 1;
}

print Dumper(\%HASH);
