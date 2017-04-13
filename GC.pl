open IN,"$ARGV[0]" or die""; 
print "ID Total_gc Total_len GC_ratio\n";
$/='>';
<IN>;
while(<IN>)
{
	chomp;
	($gene,$seq) = split(/\n/,$_,2);
	$seq =~ s/\s+//g; 
	$lena= length $seq;
	$seq=~ s/A//ig;
	$seq=~ s/T//ig;
	$lenb=length $seq;
	$GC=sprintf("%.4f",($lenb/$lena))*100;
	print "$gene $lenb $lena $GC\%\n";
}
