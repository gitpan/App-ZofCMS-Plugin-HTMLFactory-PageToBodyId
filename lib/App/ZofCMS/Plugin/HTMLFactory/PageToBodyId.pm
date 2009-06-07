package App::ZofCMS::Plugin::HTMLFactory::PageToBodyId;

use warnings;
use strict;

our $VERSION = '0.001';

sub new { bless {}, shift }

sub process {
    my ( $self, $t, $q, $config ) = @_;

    my $id = defined $t->{body_id}
                ? $t->{body_id}
                : defined $config->conf->{body_id}
                ? $config->conf->{body_id}
                : make_id( $q );

    delete $config->conf->{body_id};
    delete $t->{body_id};

    $t->{t}{body_id} = $id;

    return 1;
}

sub make_id {
    my $q = shift;

    defined $q->{dir}
        or $q->{dir} = '';

    defined $q->{page}
        or $q->{page} = '';

    my $id = $q->{dir} . $q->{page};

    $id =~ s/[^\w:.-]/_/g;

    return "page$id";
}

1;

__END__

=head1 NAME

App::ZofCMS::Plugin::HTMLFactory::PageToBodyId - plugin to automatically create id="" attributes on <body> depending on the current page

=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use App::ZofCMS::Plugin::HTMLFactory::PageToBodyId;

    my $foo = App::ZofCMS::Plugin::HTMLFactory::PageToBodyId->new();
    ...

=head1 DESCRIPTION

ID and NAME tokens must begin with a letter ([A-Za-z]) and may be followed by any number of letters, digits ([0-9]), hyphens ("-"), underscores ("_"), colons (":"), and periods (".").

=head1 AUTHOR

'Zoffix, C<< <'zoffix at cpan.org'> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-app-zofcms-plugin-htmlfactory-pagetobodyid at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=App-ZofCMS-Plugin-HTMLFactory-PageToBodyId>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc App::ZofCMS::Plugin::HTMLFactory::PageToBodyId


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=App-ZofCMS-Plugin-HTMLFactory-PageToBodyId>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/App-ZofCMS-Plugin-HTMLFactory-PageToBodyId>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/App-ZofCMS-Plugin-HTMLFactory-PageToBodyId>

=item * Search CPAN

L<http://search.cpan.org/dist/App-ZofCMS-Plugin-HTMLFactory-PageToBodyId/>

=back


=head1 COPYRIGHT & LICENSE

Copyright 2009 'Zoffix, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.


=cut
