open IN,"$ARGV[0]" or die""; 
my @a;
while (<IN>){
chomp;
@a=split;
print "$a[2]\n";
}
