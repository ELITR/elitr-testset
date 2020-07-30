#!/usr/bin/env perl
# processes stdin and prepends each line with unix timestamp

use Time::HiRes qw(time);
use strict;

$| = 1;
while (<>) {
  print time(), " ", $_;
}
