use 5.008;    # utf8
use strict;
use warnings;
use utf8;

package Dist::Zilla::Plugin::INI::Baked;

our $VERSION = '0.001000';

# ABSTRACT:

our $AUTHORITY = 'cpan:KENTNL'; # AUTHORITY

use Moose;

__PACKAGE__->meta->make_immutable;
no Moose;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Dist::Zilla::Plugin::INI::Baked - # AUTHORITY

=head1 VERSION

version 0.001000

=head1 AUTHOR

Kent Fredric <kentfredric@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Kent Fredric <kentfredric@gmail.com>.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
