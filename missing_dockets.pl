#!/usr/bin/env perl
 
use 5.010000;
use warnings;
use strict;
use POSIX;

my $args 		= $#ARGV + 1;
my $filename 	= $ARGV[0]; 

say "Number of arguments: $args";
say "File name: $filename";

if($args != 1) {
	say "\nUsage: name.pl filename";
	exit;
}

print "Restaurant name: ";
my $rest 		= <STDIN>;
chomp($rest);

print "Shift: [day of week/day eve] [dd/mm/yy]: "
my $shift		= <STDIN>;
chomp($shift);

open(my $fh, '>', $filename) or die "cannot open '$filename' $!";
print $fh "$rest\n$shift\n\n";

close $fh;

say "Done!";


=begin
my $docket_total = 0;

while(my $line = <$fh>) {
  chomp($line);
  my ($rest_name, $rest_dockets) = split(/: +/, $line, 2);
  die "malformed '$line'" unless(defined $rest_dockets);
  say "$rest_name: $rest_dockets";
  $docket_total = $docket_total + $rest_dockets;
 }

# say "We require $docket_total dockets each week.";

my $fortnight 			= $docket_total * 2;
my $boxes_per_fortnight	= ceil($fortnight / 6000);

say "We require $fortnight dockets per fortnight, equating to $boxes_per_fortnight boxes per fortnight."
=cut
