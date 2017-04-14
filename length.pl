open IN,"$ARGV[0]" or die""; 
$/='>';
<IN>;
while(<IN>){
	chomp;
	($gene,$seq) = split(/\n/,$_,2);
	$length = length $seq ;
	print "$gene $length\n";
}
