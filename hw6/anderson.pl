#!/usr/bin/perl 
#Steven Anderson

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
my @fullname = split ' ', $fields[0];  #Split fields0 into parts so I can sep first and last
my $sta = substr $fields[2], -8, 2;
my $line = "$fullname[1], $fullname[0], $sta";  ##Compose complete line and add to array
push @comp, $line;


}
my @sorted_states = sort { substr($a, -2, 2) cmp substr($b, -2, 2) } @comp;  ##Sort new lines before output

foreach $sorted_states (@sorted_states) { ##Print new lines to output files
	print $state $sorted_states;	
	print $state "\n";
	
}

close $state;               #close states.txt


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
if(length($month[0])<2){$line = "$fullname[1]\t$fullname[0]\t0$dob";} #compare months to makesorting easier
else{$line = "$fullname[1], $fullname[0]\t $dob";}
push @final, $line;

}

my @sorted_dob = sort { substr($a, -9, 3) <=> substr($b, -9, 3) } @final;	#sort months for output


foreach $sorted_dob (@sorted_dob) {  ##Print sorted list to output file
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

push @salary, $line;     ##add salary to lines to be sorted

}
my @sorted_sal = sort { substr($b, -7, 7) cmp substr($a, -7, 7) } @salary;  #sort based on final 7 characters

foreach $sorted_sal (@sorted_sal) {
	print $sal $sorted_sal;	   #Print sorted list to output files
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







