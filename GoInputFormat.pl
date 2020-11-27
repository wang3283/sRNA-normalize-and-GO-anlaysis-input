#!/perl -w
#USDAGE: perl GoInputFormat.pl <edgeR_output_files_folder> > <DEGeneList_output>
#edgeR output files need put into same folder. the output file need include three columns with the format below:
#gene	logFC	pvalue
@file=glob("$ARGV[0]/*");
foreach(sort @file){
	$file=$_;
	@path=split/\//,$_;
	$name=$path[-1];
	$file{$name}=1;
	open(R,"$file");
	while(<R>){
		chomp;
		@a=split/\t/,$_;
		next if !($a[2]=~/^\d+.?\d+$/);
		$gene{$a[0]}=1;
		${$name}{$a[0]}="nochange" if $a[-1] >=0.05;
		${$name}{$a[0]}="up-regulated" if $a[-1] <0.05 and $a[1] >0 ;
		${$name}{$a[0]}="down-regulated" if $a[-1] <0.05 and $a[1] <0 ;
	}
}
print "GeneID";
foreach(sort keys %file){
	print "\t$_";
}
print "\n";

foreach(sort keys %gene){
	$gene=$_;
	print "$gene";
	foreach(sort keys %file){
		print "\t${$_}{$gene}" if exists ${$_}{$gene};
		print "\tnan" if !(exists ${$_}{$gene});
	}
	print "\n";
}