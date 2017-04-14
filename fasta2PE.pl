#!/usr/bin/perl -w

###This script is used for scaffolding
###It takes fasta file (long reads or contigs) and convert it to pair-end fastq file with expected insert size

use Getopt::Std;
getopts "i:f:o:l";


if ((!defined $opt_i)|| (!defined $opt_f)  || (!defined $opt_o)) {
    die "************************************************************************
    Usage: perl $0 -f input.fasta -i insert_size -o output_label 
      -h : help and usage.
      -f : input.fasta
      -i : insert size
      -o : output label
      -l : length or reads, default 100
************************************************************************\n";
}else{
  print "************************************************************************\n";
  print "Version 1.0\n";
  print "Copyright to Tanger, tanger.zhang\@gmail.com\n";
  print "RUNNING...\n";
  print "Output reads are paired-end, not mate-pair\n";
  print "************************************************************************\n";
     }

my $len_of_reads = (defined $opt_l)?$opt_l:100;
my $R1_reads     = $opt_o.".R1.fastq";
my $R2_reads     = $opt_o.".R2.fastq";
my $qual         = "I" x $len_of_reads;
my ($a,$b,$contig,$rn1,$rn2,$r1,$r2,$rcount,$r_contig);

my $insize = $opt_i;
if($insize =~ /(\d+)[K|k]/){
	$insize = $1 * 1000;
	}

open(OUT1, "> $R1_reads") or die"";
open(OUT2, "> $R2_reads") or die"";
open(IN, $opt_f) or die"";
$/='>';
<IN>;
while(<IN>){
	chomp;
	my ($name,$seq) = split(/\n/,$_,2);
	$name =~ s/\s+.*//g;
	$seq  =~ s/\s+//g;
	my $len = (length $seq) - $insize;
	for(my $i=1;$i<=$len;$i=$i+$len_of_reads){
		$a = $i; $b = $a + $insize - 1;
		$contig   = substr($seq,$a,$insize);
		$r1       = substr($contig,0,$len_of_reads);
		$r_contig = reverse $contig;
		$r_contig =~ tr/ATGCN/TACGN/;
		$r2      = substr($r_contig,0,$len_of_reads);
		$rcount++;
		$rn1     = "\@HWI-D00258:".$name.":".$a.":".$b.":".$rcount." 1:N:0";
		$rn2     = "\@HWI-D00258:".$name.":".$a.":".$b.":".$rcount." 2:N:0";
		print OUT1 "$rn1\n$r1\n+\n$qual\n";
		print OUT2 "$rn2\n$r2\n+\n$qual\n";
		}
	}
close IN;
close OUT1;
close OUT2;












