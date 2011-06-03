#!/usr/bin/perl

use DBI;
use Data::Dumper;

my $mysql_servername = "192.168.1.211";
my $mysql_port = 4040;

while (1) {
	my $dbh = DBI->connect("dbi:mysql:replication_test;host=$mysql_servername;port=$mysql_port","selectuser","password") or die $!;
	my $sql = "select now(),count(*) from people";
	my $sth = $dbh->prepare($sql);

	$sth->execute or die $!;

	while (@row = $sth->fetchrow_array) {
		print "@row\n";
	}
sleep 1;
}



