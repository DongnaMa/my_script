open IN,"$ARGV[0]" or die""; 
while (<IN>){
chomp;
next if(/#/);
my @data = split;
my $num_of_missing_data = 0; 
my $num_of_samples = @data - 8;
foreach my $i(9..$#data){
$num_of_missing_data++ if($data[$i] eq "./.");  
my @tmpdb = split(/:/,$data[$i]);
		next if(@tmpdb<2);
		my $ad = $tmpdb[1];
		$num_of_missing_data++ if($ad eq ".");
		next if($ad eq ".");
		my ($ref_d,$alt_d) = split(/,/,$ad);
		my $combine_ad     = $ref_d + $alt_d;
		$num_of_missing_data++ if($combine_ad<$cutoff_AD);
my $mr_tmp = sprintf("%.2f",$num_of_missing_data/$num_of_samples) ;  
 print "$mr_tmp\n";
	}
}
