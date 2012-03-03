#!/usr/bin/perl

my @colors = ("red", "black");

my $bankroll = 10;

my $current_pick = "red";
my $current_bet = 1;

my $ball_lands_on;
while ( $bankroll > 0 and $bankroll < 20 and $bankroll >= $current_bet ) {
	print "I put $current_bet on $current_pick\n";
	sleep 1;
	$ball_lands_on = $colors[int(rand(2))];
	print "Ball lands on $ball_lands_on\n";

	if ($current_pick eq $ball_lands_on ) {
		print "I win!\n";
		$bankroll += $current_bet;
		print "Bankroll at $bankroll\n";
		$current_bet = 1;
		if ($ball_lands_on eq "red") {
			$current_pick = "black";
		} else {
			$current_pick = "red";
		}
		#$current_pick = $colors[int(rand(2))];
	} else {
		print "I lose.\n";
		$bankroll -= $current_bet;
		print "Bankroll at $bankroll\n";
		#$current_bet = 2*$current_bet;
		$current_bet++;
	}
	print "\n";
	sleep 2;
}

print "Terminating because bankroll = $bankroll\n";

