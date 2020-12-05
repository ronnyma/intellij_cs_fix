#!/usr/bin/perl -w

# Intellij-fix for case sensitive filesystems on OS X

use File::Find;
use Term::ANSIColor qw(:constants);
use strict;
use warnings;

# If you have a different folder for the config, this must be updated.
my $dir = '~/Library/Application\ Support/JetBrains';

find(\&read_and_modify, glob($dir));

sub read_and_modify
{
  if (/idea.properties/){
    my $file = $File::Find::name if /idea.properties/;

    my $cs = 0;
    open my $handle, '<', $file or die "Could not open file $file";
    my @lines;
    chomp(@lines = <$handle>);
    close $handle;

    for my $l (@lines) {
      if ($l =~ /idea\.case\.sensitive\.fs=/) {
        $cs = 1;
      }
    }
    if(!$cs)
    {
      print GREEN "Adding directive to $file\n";
      open(my $fh, '>>', $file) or die 'Could not open.';
      print $fh "idea.case.sensitive.fs=true";
      close($fh);
    }
    else
    {
      print RED "$file already contained filesystem option or is set to false.\n";
    }
  }
}
