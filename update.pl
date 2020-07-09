#!/usr/bin/perl -w

#Intellij-fix for case sensitive filesystems on OS X

use File::Find;
use Term::ANSIColor qw(:constants);
use strict;
use warnings;
use Cwd qw(getcwd);

my $dir = '~/Library/ApplicationSupport/JetBrains';

chdir $dir;


find(\&read_and_modify, glob($dir));

sub read_and_modify
{
  my @lines;
  if (/idea.properties/){
    my $file = $File::Find::name if /idea.properties/;

    my $cs = 0;
    open my $handle, '<', $file;
    chomp(@lines = <$handle>);
    for my $l (@lines) {
      if ($l =~ /case.sensitive/) {
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
      print RED "$file already contained filesystem option.\n";
    }
    close $handle;
  }
}
