#!/usr/bin/perl

$counter=0;
select STDIN;
$|=1;

select STDOUT;
$|=1;

sub topTen {
my (%hash)  = @_;
my $num=10;
my %result;
my $n=0;


#foreach $key (keys %hash) {
#print "DEBUG RICEVUTO $key ".$hash{$key}."\n";
#}
LOOP: foreach $k (reverse sort {$hash{$a} <=> $hash{$b} }
                    keys %hash)
                {
#	print "DEBUG nome_pacchetto $value contatore-value".$hash{$value}."\n";
			$result{$k}=$hash{$k};
                        $n++;
                        if ($n==$num) { last LOOP;}
                        }

return %result;

}
while(<>) {
print "+";
$counter++;
	chomp;
	($codice_http,$byte,$pacchetto) = split / /;

	$numero{$pacchetto}++;
	if($codice_http =~ m/^20/) {
		$byte{$pacchetto}+=$byte;
	}

	if( $counter == 78 ) {
print "\n";
		$counter=0;
		print "TOP 10 COUNT\n";
		%r=topTen(%numero);
	
		foreach $value (reverse sort {$r{$a} <=> $r{$b} }
                    keys %r) {
			print $value . " ". $r{$value}."\n";

		}
		print "\nTOP 10 BYTE\n";
		%s=topTen(%byte);

		foreach $value (reverse sort {$s{$a} <=> $s{$b} }
                    keys %s) {
                        print $value . " ". $s{$value}."\n";

                }

		print "\n\n";

	}


}
