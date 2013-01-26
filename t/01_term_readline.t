use strict;
use warnings;
use utf8;
use Test::More;

BEGIN {
    $ENV{PERL_RL} = 'EditLine';
    require Term::ReadLine;
}

my $t = Term::ReadLine->new('test term::readline::editline');
is($t, 

done_testing;

