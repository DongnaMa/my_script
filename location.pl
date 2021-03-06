my $header;
my $seq = "";
my $fastaFile = "fasta file";
my %seq;
open IN, "$fastaFile" or die "Cannot find the specified fasta file $fastaFile";
while(my $line=<IN>){
        chomp($line);
        if ($line=~/^>/){ #the header line
                if (length $seq > 0){ #not the first line
                        $seq{$header} = $seq;
                }
                $header = substr($line,1); #remove >
                $seq = "";
        }else{
                $seq.=$line;
        }
}
$seq{$header} = $seq;
close IN;

open IN, "local txt";
open OUT, ">fasta file";
while (my $line = <IN>){
     chomp ($line);
     my ($chr,$pos)=split (":",$line);
     my ($start,$end)=split ("-",$pos);
     my $seq = $seq{$chr};
     my $part = substr($seq,$start-1, $end-$start+1); #add +1 or -1 after testing
     print OUT ">$line\n$part\n";
}
close IN;
close OUT;
