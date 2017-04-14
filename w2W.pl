open IN,"$ARGV[0]" or die""; 
$/='>';
<IN>;
while(<IN>){
	chomp;
	($gene,$seq) = split(/\n/,$_,2);
        $gene =~ s/\s+.*//g;
	$seq  =~ s/\s+//g;
	$WD  = uc $seq;
	print OUT ">$gene\n$WD\n";
	}
close IN;
close OUT;
