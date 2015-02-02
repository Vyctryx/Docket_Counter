#!/usr/bin/env perl
 
use 5.010000;
use warnings;
use strict;
use POSIX;

print "Enter the file name: ";

my $filename = <>;
chomp($filename);

# my $filename = 'restaurants.txt';
 
open(my $fh, '<', $filename) or die "cannot open '$filename' $!";
 
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
