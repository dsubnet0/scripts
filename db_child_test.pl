#!/usr/bin/perl

use DBI;
use Data::Dumper;


for (my $i=0; $i<20; $i++) {
        my $kidPid = fork();
        my $localtime1 = localtime(time);

        if ($kidPid) { # I'm the parent
                #print "process $kidPid launched at  $localtime1...\n";
		insert_start($kidPid,$localtime1);
        } else {
                sleep 2;
                my $localtime2 = localtime(time);
                #print "I'M CHILD $$.  WAITED 2.  TIME IS $localtime2.  EXITING NOW.\n";
		update_end($$,$localtime2);
                exit();
        }

        print "ending iteration $i...\n";
        sleep 1;
}



sub insert_start {
	my ($pid,$starttime) = @_;
	my $dbh = DBI->connect("dbi:mysql:load_test","writeuser","password") or die $!;
	#my $sql = "INSERT INTO fork_test (pid,starttime) VALUES ($pid,'$starttime')";
	my $sql = "INSERT INTO fork_test (pid,starttime) VALUES ($pid,now())";
	print "$sql\n";
	my $sth = $dbh->prepare($sql);
	$sth->execute or die $!;

	print "start row inserted\n";
}

sub update_end {
	my ($pid,$endtime) = @_;
	my $dbh = DBI->connect("dbi:mysql:load_test","writeuser","password") or die $!;
	#my $sql = "UPDATE fork_test SET endtime = '$endtime' WHERE pid = $pid";
	my $sql = "UPDATE fork_test SET endtime = now() WHERE pid = $pid";
	print "$sql\n";
	my $sth = $dbh->prepare($sql);
	$sth->execute or die $!;

	print "end row updated\n";
}
