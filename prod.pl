#!/usr/bin/perl

my @options = ('0','1','-');
print "SP\tSE\tOP\tOE\n";
foreach $x (@options) {
	foreach $y (@options) {
		foreach $z (@options) {
			foreach $w (@options) {
				print "'$x'\t'$y'\t'$z'\t'$w'\t\n";
			}
		}
	}
}

