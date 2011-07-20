#!/usr/bin/perl

use Data::Dumper;
open (INFILE,"/home/Douglas/files/phpqueries_trim") or die $!;

my @files;
my %SQLHASH;
my %PREDICATES;
while (<INFILE>) {
	my $line = $_;
	chomp $line;
	my @line = split(/:/,$line);	
	my $file = shift @line;
	my @sql = split(/"/,"@line");
	my $sql = $sql[1];
	
	#if ($sql =~ /^select|^insert|^update|^delete/i) {
	if ($sql =~ /^select/i && !($sql =~ /JOIN/i)) {
		push(@{$SQLHASH{$file}},$sql);
	}
}

#print Dumper(\%SQLHASH);
my $tableList,$from,$where,$where_clause,@currSql;

foreach my $currFile (keys %SQLHASH) {
	foreach my $currSql (@{$SQLHASH{$currFile}}) {
		@currSql = split(' ',$currSql);
	
		if (ArraySearch(\@currSql,"\\(SELECT") >=0 ) {
		} elsif (ArraySearch(\@currSql,"where") >= 0 ) {
			#print "currSql = $currSql\n";
			#print "where found\n";
			$from = ArraySearch(\@currSql,"from");
			$where = ArraySearch(\@currSql,"where");
			#print "".($from+1)."->".($where-1)."\n";
			$tableList = "@currSql[($from+1)..($where-1)]";

			$where_clause = "@currSql[($where+1)..(@currSql-1)]";

			#print "where_clause: $where_clause\n";
			#print "tableList: $tableList\n\n";

			push(@{$PREDICATES{$tableList}},$where_clause);
		} else {
		}
	}
}

#print Dumper(\%PREDICATES);

my @keys = sort keys %PREDICATES;
foreach my $key (@keys) {
	print "$key => [\n";
	foreach my $value (sort @{$PREDICATES{$key}}) {
		print "\t\t$value,\n";
	}
	print "]\n\n";
}


sub ArraySearch {
	my @array = @{$_[0]};
	my $string = $_[1];

	for (my $i=0;$i<@array;$i++) {
		if ($array[$i] =~ /^$string$/i) {
			return $i;
		}
	}
	return -1;
}
