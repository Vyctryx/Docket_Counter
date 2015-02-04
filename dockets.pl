#!/usr/bin/env perl
 
use 5.010000;
use warnings;
use strict;
use POSIX;

my $break_out = 0;

say "Welcome to the docket system!";

while (!$break_out) {
	print "(1) Calculate dockets required per fortnight.\n(2) Calculate dockets currently in stock.\n(3) Record missing dockets.\n(Q) Quit.\n";
	print "Please enter your selection: ";
	my $choice = <STDIN>;
	chomp($choice);

	say "You have chosen option ($choice)!";

	if($choice =~ /^q|Q/){
		$break_out = 1;
	}
	elsif($choice == 1) {
		docket_calc();
	}
	elsif($choice == 2) {
		docket_stock();
	}
	elsif($choice == 3) {
		missing_dockets();
	}
	else {
		say "Invalid choice!"
	}
}

sub docket_calc {

	say "You have chosen \"Calculate dockets required per fortnight.\"";

	print "Enter input filename: ";
	my $filename = <STDIN>;
	chomp ($filename);

	open(my $fh, '<', $filename) or die "cannot open '$filename' $!";

	my $docket_total = 0;

	while(my $line = <$fh>) {
		chomp($line);
  		my ($rest_name, $rest_dockets) = split(/: +/, $line, 2);
  		die "Malformed '$line'" unless(defined $rest_dockets);
  		say "$rest_name: $rest_dockets";
	  	$docket_total = $docket_total + $rest_dockets;
 	}

	my $fortnight 		= $docket_total * 2;
	my $boxes_per_fortnight	= ceil($fortnight / 6000);

	say "We require $fortnight dockets per fortnight, equating to $boxes_per_fortnight boxes per fortnight.";

	return;
}

sub docket_stock {

	say "You have chosen \"Calculate dockets currently in stock.\"";
	print "How many boxes are in stock? ";

	my $boxes	 = <>;
	my $dockets	 = $boxes * 6000;

	print "How many boxes do we need per week? ";

	my $boxes_per_wk = <>;
	my $weeks 	 = floor($boxes / $boxes_per_wk);

	say "WOW! You have $dockets dockets in stock! That equates to $weeks weeks of dockets.";

	return;
}

sub missing_dockets {

	say "You have chosen \"Record missing dockets.\"";
	say "This section has not yet been implemented, sorry!";

	return;
}
