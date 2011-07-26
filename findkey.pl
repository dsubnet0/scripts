#!/usr/bin/perl

use XML::Simple;
use Data::Dumper;
use Switch;

open (INFILE,"/home/dvhollen/lms_db.xml") or die "Cannot open xml";
$xml = new XML::Simple;
$xmldata = $xml->XMLin("/home/dvhollen/lms_db.xml");

my $title = "Ways Of The World";
        foreach my $currBook (@{$xmldata->{book}}) {
                if ($currBook->{title} =~ /$title/i) {
                        print $currBook->{title}."\n";
                }
        }
