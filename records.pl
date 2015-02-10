#!/usr/bin/env perl
 
use 5.010000;
use LWP::Simple;
use Data::Dumper;
use warnings;
use strict;
use POSIX;
use JSON qw( decode_json );

binmode STDOUT, ":utf8";
use utf8;

# Slurp the file
my $json;
{
	local $/;
	open my $fh, "<", "data.json";
	$json = <$fh>;
	close $fh;
}

# Decode it
my $data = decode_json($json);

my $break_out = 0;

say "\tWELCOME TO THE DOCKET RECORD SYSTEM!";

while (!$break_out) {
	print "-----------------------------------------------------------\n";
	print "(1)\tPrint out missing dockets.\n(2)\tAdd new dockets.\n(3)\tModify dockets.\n(4)\tDelete dockets\n(Q)\tQuit.\n";
	print "-----------------------------------------------------------\n";
	print "Please enter your selection: ";
	my $choice = <STDIN>;
	chomp($choice);

#	say "You have chosen option ($choice)!";

	if($choice =~ /^q|Q/){
		$break_out = 1;
	}
	elsif($choice == 1) {
		output_file();
	}
	elsif($choice == 2) {
		new_entry();
	}
#	elsif($choice == 3) {
#		missing_dockets();
#	}
	else {
		say "\nInvalid choice! Please select another option:\n"
	}
}

sub output_file {
	
	# Print it out while there's still data in the file. 
	# Not sure about the tabbing but it seems to line up for me.
	
	print "\n----MISSING DOCKETS----\n";

	for ( @{$data->{data}}) {
		print "\nRestaurant:\t" . $_->{'name'} . "\n";
		print "Shift:\t\t" . $_->{'shift'}->{'date'} . " - " . $_->{'shift'}->{'type'} . "\n";
		print "Week ending:\t" . $_->{'weekending'} . "\n";
		print "Details:\t" . $_->{'details'} . "\n\n";
	}

	# Hackish nonsense because lame.
	print "Press Enter/Return to return to the main menu.\n";
	my $choice = <STDIN>;
	if (defined ($choice))
	{
		return;
	}
}

sub new_entry {
	my $continue 	= 0;
	my $name	= "";
	my $shift 	= "";
	my $date	= "";
	my $type	= "";
	my $week	= "";
	my $details	= "";

	# Must find end of thing and insert there.
	# Uh oh.
	# A little something like this: $_->[@#data] or something oh god what now.
	while (!$continue) {
		print "Restaurant abbreviation: ";
		my $name = <STDIN>;
		chomp($name);



		my $new_entry = "{
\"data\" :
[
	{
		\"name\" : \"$name\",
		\"shift\": {
			\"date\" : \"$date\",
			\"type\" : \"$type\"
		},
		\"weekending\" : \"$week\",
		\"details\" : \"$details\"
	}
]
}";
		open my $fh, ">", "data.json";
		print $fh encode_json($new_entry);
		close $fh;

		$continue = 1;
	}

	return;
}

# Next - try accepting some input to turn into some sweet, sweet JSON and write it to the file.
# After that we'll do menus, and deleting/modifying entries.
# Then some regexps and any other sweet stuff to check inputs are valid.
# Then we've pretty much won at life. Kick back beneath a cloud of smug.

=head - Some stuff I'm keeping around for reference, because it's radpants awesome.

print "City: " . $decoded->{'address'}{'city'} . "\n";

my @friends = @{ $decoded->{'friends'} };
foreach my $f (@friends) {
	print $f->{"name"} . "\n";
}

my $trendsurl = "https://graph.facebook.com/?ids=http://www.filestube.com";

my $json = get( $trendsurl );
die "Could not get $trendsurl!" unless defined $json;

my $decoded = decode_json( $json );

print Dumper $decoded;
=cut

