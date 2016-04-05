#!/usr/bin/perl 

##Variables##
my $data = "$ARGV[0]";
my @lines;

###Opening files for use#####
open(my $Odata, $data);
open(my $state, '>', 'state.txt');
open(my $birth, '>', 'dob.txt');
open(my $sal, '>', 'salary.txt');




while (my $row = <$Odata>){ ##Split the lines of databook.txt up into an array called lines
	chomp $row;
	
	push @lines, $row;
	

}



###States file#######
my @comp;

foreach $lines (@lines){ 
my @fields = split /:/, $lines;
my @fullname = split ' ', $fields[0];
my $sta = substr $fields[2], -8, 2;
my $line = "$fullname[1], $fullname[0], $sta";
push @comp, $line;


}
my @sorted_states = sort { substr($a, -2, 2) cmp substr($b, -2, 2) } @comp;

foreach $sorted_states (@sorted_states) {
	print $state $sorted_states;	
	print $state "\n";
	
}

close $state;


###End of states file#########



#### DOB section ###########
my @final;
my $line;
my $dob;

foreach $lines (@lines){ 
my @fields = split /:/, $lines;
my @fullname = split ' ', $fields[0];
$dob = $fields[3];
my @month = split '/', $dob;
if(length($month[0])<2){$line = "$fullname[1]\t$fullname[0]\t0$dob";}
else{$line = "$fullname[1], $fullname[0]\t $dob";}
push @final, $line;

}

my @sorted_dob = sort { substr($a, -9, 3) <=> substr($b, -9, 3) } @final;


foreach $sorted_dob (@sorted_dob) {
	print $birth $sorted_dob;
	print $birth "\n";
	
}



### Salary Section ######
my @salary;
my $line;


foreach $lines (@lines){ 
my @fields = split /:/, $lines;
my @fullname = split ' ', $fields[0];
$line = "$fullname[1], $fullname[0]\t\$$fields[4] ";

push @salary, $line;

}
my @sorted_sal = sort { substr($b, -7, 7) cmp substr($a, -7, 7) } @salary;

foreach $sorted_sal (@sorted_sal) {
	print $sal $sorted_sal;	
	print $sal "\n";
	
}


### Display All Information for employees in IL ###
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "~~~~~~~~~Employees livining in IL~~~~~~~~~\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
foreach $lines (@lines){
my @fields = split /:/, $lines;
my $sta = substr $fields[2], -8, 2;
if($sta eq "IL"){
print "$lines\n\n";}
}



### Display All Information for employees making more than 40k ###
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "~~~~~~~~~Employees  making greater than 40k~~~~~~~~~\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";

foreach $lines (@lines){
my @fields = split /:/, $lines;
my $earnings = $fields[4];
if($earnings > 40000){
	print "$lines\n";
	}
}


### Display All Information for employees Born In The 1960s ###
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";
print "~~~~~~~~~Employees Born In The 1960~~~~~~~~~~~~~~~~~\n";
print "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n";

foreach $lines (@lines){
my @fields = split /:/, $lines;
my @fullname = split ' ', $fields[0];
if(substr($fields[3], -2, 2) >= "60"){
print "$lines\n";}
}







