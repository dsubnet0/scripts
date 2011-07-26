#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;

open (INFILE,"/home/dvhollen/lms_db.xml") or die "Cannot open xml";

$xml = new XML::Simple;

$data = $xml->XMLin("/home/dvhollen/lms_db.xml");

foreach $currBook (@{$data->{book}}) {
	if ($currBook->{title} eq "Developing Person Through the Life Span, 7e") {
		print "author = ".$currBook->{author}."\n";
		#print "blackboard = ".$currBook->{blackboard}."\n";
		#%blackboard = $currBook->{blackboard};
		#print Dumper ($currBook->{blackboard});
		print "path = ".$currBook->{blackboard}->{file}[0]->{path}."\n";
	}
}

#print Dumper ($data);
