#!/perl -w
#USAGE: perl sRNA_normalize.pl <input_reads_count.txt> > <Output_file>
open(Input, $ARGV[0]);
while(<Input>){
	chomp;
	@a=split/\t/,$_;
	next if !($a[1]=~/^\d+$/);
   for($i=1;$i<@a;$i++){
   	$total_reads{$i}+=$a[$i];
   }
}
close(Input);
open(Input, $ARGV[0]);
while(<Input>){
	chomp;
	@a=split/\t/,$_;
	next if !($a[1]=~/^\d+$/);
	print "$a[0]";
   for($i=1;$i<@a;$i++){
   $cpm=$a[$i]/$total_reads{$i}*1000000;
   print "\t$cpm";
   }
   print "\n";
}