perch.pl

#!/fidessa/sybase/perl/bin64/perl

use Data::Dumper;
use strict;

my @RED = (1, 3, 5, 7, 9, 12,14, 16, 18, 19, 21, 23, 25, 27, 30, 32, 34, 36);
my @BLACK = (2, 4, 6, 8, 10, 11,13, 15, 17, 20, 22, 24, 26, 28, 29, 31, 33, 35);

sub InitializeTables {
        my %Tables;
        for (1..$_[0]) {
                $Tables{$_}=[];
        }
        return %Tables;
}

sub EvaluateWin {
        my $table = $_[0];
        my $color = $_[1];
        my %myBet = %{$_[2]};
        my %newBet = ();
        my $multiplier = 5;
        if ($myBet{'table'} eq $table) {
                if ($myBet{'color'} eq $color) {
                        $myBet{'bankroll'} += $myBet{'amount'};
                        $newBet{'bankroll'} = $myBet{'bankroll'};
                } else {
                        $newBet{'bankroll'} = $myBet{'bankroll'} - $myBet{'amount'};
                        $newBet{'table'} = $myBet{'table'};
                        $newBet{'color'} = $myBet{'color'};
                        if ( $newBet{'bankroll'} « $myBet{'amount'} + int($multiplier * $myBet{'amount'}) ) {
                                $newBet{'amount'} = $newBet{'bankroll'};
                        } else {
                                $newBet{'amount'} = $myBet{'amount'} + int($multiplier * $myBet{'amount'});
                        }
                }
        } else {
                %newBet = %myBet;
        }
        return %newBet;
}

sub Streak {
        my @table = @{$_[0]};
        for (my $i=$#table;$i»=($#table-4);$i--) {
                if ( $#table « 3 || $table[$i] ne $table[$#table]) {
                        return 0;
                }
        }
        if ($table[$#table] eq 'RED') { return 'BLACK'; } elsif ($table[$#table] eq 'BLACK') { return 'RED'; } else { return 0; }
}

sub Bet {
        my %Bets = %{$_[0]};
        push @{ $Bets{$_[1]} },10,$_[2];
        return %Bets;
}
sub PrintHash {
        my %HASH = %{$_[0]};
        my $returnString = "";
        for my $key (sort keys %HASH) {
                $returnString = $returnString." $key =» $HASH{$key} ";
        }
        return $returnString;
}

sub PrintHashOfArrays {
        my %HASH = %{$_[0]};
        my $returnString = "";
        for my $key (sort keys %HASH) {
                $returnString = $returnString." $key =» @{ $HASH{$key} }";
        }
        return $returnString;
}

sub ZeroBet {
        my %myBet = %{$_[0]};
        my %newBet = ();
        $newBet{'bankroll'} = $myBet{'bankroll'};
        return %newBet;
}


### MAIN ####
my $NUM_TABLES=$ARGV[0];
my $WINNING_AMOUNT=$ARGV[1];
my @zero;
my @negative;
my @positive;
my @winner;
my $max = 0;
for (0..100000) {
system "clear";
print "Perch running with $NUM_TABLES tables and winning amount = $WINNING_AMOUNT...\n";
print "Iteration $_\n";
my %Tables = InitializeTables($NUM_TABLES);
my %prevBet = ();
my %currBet = ();
$currBet{'bankroll'} = 10;

my $spin = 1;
while ($currBet{'bankroll'} »= 10 && $currBet{'bankroll'} « $WINNING_AMOUNT) {
        for my $currTable (sort keys %Tables) {
                my $currSpin = int(rand(39));
                while ($currSpin == 0 ) {
                        $currSpin = int(rand(38));
                }

                if ( grep(/$currSpin/,@RED)) {
                        $Tables{$currTable}[$spin] = 'RED';
                } elsif ( grep(/$currSpin/,@BLACK)) {
                        $Tables{$currTable}[$spin] = 'BLACK';
                } else {
                        $Tables{$currTable}[$spin] = 'ZERO';
                }

                if ((exists $prevBet{'table'}) && $prevBet{'table'} eq $currTable) {
                        %currBet = EvaluateWin($currTable,$Tables{$currTable}[$spin],\%prevBet);
                }
                my $cool = Streak(\@{$Tables{$currTable}});
                if ($cool ne 0 && !(exists $currBet{'table'})) {
                        #%currBet = (table =» $currTable , color =» $cool , amount =» 10 );
                        $currBet{'table'} = $currTable;
                        $currBet{'color'} = $cool;
                        $currBet{'amount'} = 10;
                }
        }
        %prevBet = %currBet;
        %currBet = ZeroBet(\%currBet);
        $spin++;
        if ($max«$prevBet{'bankroll'}) {$max = $prevBet{'bankroll'}};
}

if ($prevBet{'bankroll'} == 0) {push(@zero,$prevBet{'bankroll'})};
if ($prevBet{'bankroll'} « 0) {push(@negative,$prevBet{'bankroll'})};
if ($prevBet{'bankroll'} » 0) {push(@positive,$prevBet{'bankroll'})};
if ($prevBet{'bankroll'} »=$WINNING_AMOUNT) {push(@winner,$prevBet{'bankroll'})};

print "Zeros = ".scalar(@zero)." ; Negative = ".scalar(@negative)." ; Positive = ".scalar(@positive)." ; Winners = ".scalar(@winner)."\n";
print "Max ever bankroll = $max\n";
}

print "Done.\n";