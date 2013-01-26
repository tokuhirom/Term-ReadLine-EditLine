package Term::ReadLine::EditLine;
use strict;
use warnings;
use 5.008005;
our $VERSION = '0.01';

use Term::EditLine;
use Carp ();

sub ReadLine { __PACKAGE__ }

sub new {
    my $class = shift;
    unless (@_ > 0) {
        Carp::croak("Usage: Term::ReadLine::EditLine->new(\$program[, IN, OUT])");
    }
    my $self = bless {
        editline => Term::EditLine->new(@_),
        IN       => $_[1] || *STDIN,
        OUT      => $_[2] || *STDOUT,
    }, $class;
}

sub editline { $_[0]->{editline} }

sub readline {
    my $self = shift;
    $self->editline->gets();
}

sub addhistory {
    my ($self, $history) = @_;
    $self->history_enter($history);
}

sub IN  { $_[0]->{IN} }
sub OUT { $_[0]->{OUT} }

sub MinLine { undef }

sub findConsole {
    my $console;
    my $consoleOUT;
 
    if (-e "/dev/tty" and $^O ne 'MSWin32') {
    $console = "/dev/tty";
    } elsif (-e "con" or $^O eq 'MSWin32') {
       $console = 'CONIN$';
       $consoleOUT = 'CONOUT$';
    } else {
    $console = "sys\$command";
    }
 
    if (($^O eq 'amigaos') || ($^O eq 'beos') || ($^O eq 'epoc')) {
    $console = undef;
    }
    elsif ($^O eq 'os2') {
      if ($DB::emacs) {
    $console = undef;
      } else {
    $console = "/dev/con";
      }
    }
 
    $consoleOUT = $console unless defined $consoleOUT;
    $console = "&STDIN" unless defined $console;
    if ($console eq "/dev/tty" && !open(my $fh, "<", $console)) {
      $console = "&STDIN";
      undef($consoleOUT);
    }
    if (!defined $consoleOUT) {
      $consoleOUT = defined fileno(STDERR) && $^O ne 'MSWin32' ? "&STDERR" : "&STDOUT";
    }
    ($console,$consoleOUT);
}

sub Attribs { +{ } }

sub Features {
    +{ }
}

1;
__END__

=encoding utf8

=head1 NAME

Term::ReadLine::EditLine - ...

=head1 SYNOPSIS

  use Term::ReadLine::EditLine;

=head1 DESCRIPTION

Term::ReadLine::EditLine is

B<THIS IS A DEVELOPMENT RELEASE. API MAY CHANGE WITHOUT NOTICE>.

=head1 AUTHOR

Tokuhiro Matsuno E<lt>tokuhirom AAJKLFJEF@ GMAIL COME<gt>

=head1 SEE ALSO

=head1 LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
