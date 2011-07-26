use Data::Dumper;
use File::Find;
use File::Glob;

$|=1;
#my $directory = "D:\\BFW_include\\";
my $search_key = shift;
#my $search_key = "(webuser|macindia|perception|perception4|qmarkuser|arga2|gbuser|bbib|hclwebops|iclicker_back|iclicker|iclicker_gb_sync|poladmin|virtualit|webclicker|deployadmin|DTSUsers|QPCAdmin|QPCUser)";
my $directory = shift;
my $file_pattern = '(.txt$|.html$|.htm$|.asp$|.aspx$|.php$|.inc$|.vb$|.cs$|.asmx$|.pl$|.js$|.config$|.xml$|.ini$|.css$|.xsl$)';
#my $file_pattern = 'txt$|html$';
#my $directory = shift;

open (OUTFILE,'>search.log');
my $fh = select (OUTFILE);
$|=1;
select ($fh);

print "Searching for ".$search_key." in ".$directory." at ".datetime()."...\n";

my $file_count = 0;
my $hit_count = 0;
my @extensions = ();
print "\n";

find(\&wanted,$directory);

print "\nFinished search at ".datetime().".\n";
#foreach (@extensions) {print "$_,";}
print join(',',@extensions);







sub wanted {
	/hockenbury4e/ and $File::Find::prune =1;
	eval {
	my $file = $File::Find::name;
	#print "\rChecking file = $file               Files Checked = $file_count    Hits = $hit_count";
	print "\rFiles Checked = $file_count    Hits = $hit_count";
	return unless -f $file;
	return unless $file =~ /($file_pattern)/i;

	#print "Checking $file...\n";
	
	open(FILE,$file) or print $! && return;
	$file_count++;
	while (<FILE>) {
		chomp($_);
		#trim($_);
		if ( my ($found) = m/($search_key)/i) {
			#print OUTFILE "$file |".$_."\n";
			#print "hit in $file\n";
			my @file = split('\.',$file);
			#print Dumper(@file);
			unless($i{$file[1]}++) { push(@extensions,$file[1]); }
			$hit_count++;
			last;
		}
	}
	close FILE;

	}; 
	if ($@) {
		/Can/ and print "something went wrong...\n";
	};
	
}

sub trim($) {
	my $string = shift;
	$string =~ s/^[\s]+//;
	$string =~ s/[\s+]$//;
	return $string;
}

sub datetime {
	my @timeData = localtime(time);
	return "".($timeData[4]+1)."/$timeData[3]/".($timeData[5]+1900)." $timeData[2]:$timeData[1]:$timeData[0]";
}

sub try (&$) {
   my($try, $catch) = @_;
   eval { $try };
   if ($@) {
      local $_ = $@;
      &$catch;
   }
}

sub catch (&) { $_[0] }







