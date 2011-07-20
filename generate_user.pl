#!/usr/bin/perl

my @letter_array = (A..Z);
#first name
my $first_name = "";
my $num_letters = int(rand(10)) + 1;
for (my $i=0; $i<=$num_letters; $i++) {
	$first_name .= $letter_array[int(rand(25))];	
}

print "$first_name\n";

#last name
my $last_name = "";
my $num_letters = int(rand(10)) + 1;
for (my $i=0; $i<=$num_letters; $i++) {
	$last_name .= $letter_array[int(rand(25))];	
}

#address
my $house_number = int(rand(999));
my $street_name = "";
my $num_letters = int(rand(10)) + 1;
for (my $i=0; $i<=$num_letters; $i++) {
	$street_name .= $letter_array[int(rand(25))];	
}

#city

#state

#phone

#email

