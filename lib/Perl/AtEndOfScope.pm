package Perl::AtEndOfScope;

use 5.008;
use strict;
use warnings;

our $VERSION = '0.01';

sub new {
  my $class=shift;
  my $I=[@_];
  return bless $I=>(ref($class)||$class);
}

sub DESTROY {
  my ($fn, @args)=@{shift()};
  &{$fn}(@args);
}

1;

__END__

=head1 NAME

Perl::AtEndOfScope - run some code when a variable goes out of scope

=head1 SYNOPSIS

  use Perl::AtEndOfScope;
  use Cwd;
  {
    my $restorecwd=Perl::AtEndOfScope->new( sub{chdir $_[0]}, getcwd );
    chdir '/path/to/some/directory';
    ...
  }
  # now we are back to the old cwd

=head1 DESCRIPTION

It's often necessary to do some cleanup at the end of a scope. This module
creates a Perl object and executes arbitrary code when the object goes out
of scope.

=head1 METHODS

=over 4

=item B<< Perl::AtEndOfScope->new( $sub, @args ) >>

the constructor. The code reference passed in $sub is called with @args
as parameter list when the object is destroyed.

=item B<DESTROY( $self )>

the destructor.

=back

=head1 EXPORT

Not an Exporter.

=head1 AUTHOR

Torsten Foertsch, E<lt>torsten.foertsch@gmx.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Torsten Foertsch

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
