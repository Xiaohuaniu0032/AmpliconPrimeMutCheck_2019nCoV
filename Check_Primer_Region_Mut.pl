use strict;
use warnings;
use File::Basename;
use Getopt::Long;
use FindBin qw/$Bin/;

my $info = "$Bin/test/info.txt";
my $amplicon = "$Bin/Ion_AmpliSeq_SARS-CoV-2-Insight.20210329.designed.bed";


my %mut_pos;
open IN, "$info" or die;
while (<IN>){
	chomp;
	my @arr = split /\s+/, $_;
	if ($arr[1] =~ /(\d+)[A-Z]/){
		my $pos = $1;
		#print "$arr[0]\t$pos\n";
		my $val = "$arr[0]\:$arr[1]";
		$mut_pos{$pos}{$val} = 1;
	}
}
close IN;



open IN, "$amplicon" or die;
<IN>;
while (<IN>){
	chomp;
	my @arr = split /\t/;
	my $start = $arr[1] + 1; # 1-based
	my $end   = $arr[2];

	my $fwd_region_start = $start - 20;
	my $rev_region_start = $end + 20;

	# fwd primer
	for my $pos ($fwd_region_start..$start){
		if (exists $mut_pos{$pos}){
			my @val = keys %{$mut_pos{$pos}};
			my $val = join(",",@val);
			print "[$val] [Mut In FWD Primer]: $_\n";
		}
	}

	# rev primer
	for my $pos ($end..$rev_region_start){
		if (exists $mut_pos{$pos}){
			my @val = keys %{$mut_pos{$pos}};
			my $val = join(",",@val);
			print "[$val] [Mut In REV Primer]: $_\n";
		}
	}
}
close IN;