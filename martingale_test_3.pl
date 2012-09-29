#!/usr/bin/perl

my @colors = ("1st", "2nd", "3rd");

my $bankroll = 10;

my $current_pick = 0;
my $current_bet = 1;
$bankroll -= $current_bet;

my $ball_lands_on;
while ( $bankroll > 0 and $bankroll < 20 and $bankroll >= $current_bet ) {
	print "I put $current_bet on $colors[$current_pick]\n";
	sleep 1;
	$ball_lands_on = int(rand(3));
	print "Ball lands on $colors[$ball_lands_on]\n";

	if ($colors[$current_pick] eq $colors[$ball_lands_on] ) {
		print "I win!\n";
		$bankroll += 2*$current_bet;
		print "Bankroll at $bankroll\n";
		$current_bet = 1;
        $current_pick = ($ball_lands_on + 1) % 3;
        $bankroll = $bankroll-1;
	} else {
		print "I lose.\n";
		print "Bankroll at $bankroll\n";
		$current_bet++;
        $bankroll -= $current_bet;
	}
	print "\n";
	sleep 2;
}

print "Terminating because bankroll = $bankroll\n";

