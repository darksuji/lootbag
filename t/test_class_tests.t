use strict;
use warnings;
use v5.18;
use utf8;

use File::Spec::Functions qw( catdir );
use FindBin qw( $Bin );
use Test::Class::Moose::Load catdir( $Bin, 'lib' );

Test::Class::Moose->new( classes => \@ARGV )->runtests;

