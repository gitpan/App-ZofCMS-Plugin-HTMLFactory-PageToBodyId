package App::ZofCMS::Plugin::HTMLFactory::PageToBodyId;

use warnings;
use strict;

our $VERSION = '0.0102';

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

In your Main Config file or ZofCMS Template:

    plugins => [ qw/HTMLFactory::PageToBodyId/ ],

    body_id => 'override', # including the key overrides the plugin's value

In your L<HTML::Template> template:

    <tmpl_var escape='html' name='body_id'>

=head1 DESCRIPTION

The module is a small plugin for L<App::ZofCMS>. Its purpose is to automatically generate a
value for an C<id=""> attribute that is to be put on C<< <body> >> HTML element; this value
would be used to differentiate different pages on the site and is generated from query C<dir>
and C<page> parameters.

This documentation assumes you've read L<App::ZofCMS>, L<App::ZofCMS::Config>
and L<App::ZofCMS::Template>

=head1 MAIN CONFIG FILE OR ZofCMS TEMPLATE

=head2 C<plugins>

    plugins => [ qw/HTMLFactory::PageToBodyId/ ],

You need to add the plugin to the list of plugins to execute. Unlike many other plugins,
the C<HTMLFactory::PageToBodyId> does not require an additional key in the template and
will run as long as it is included.

=head2 C<body_id>

The plugin first checks whether or not C<body_id> first-level key was set in either
ZofCMS Template or Main Config File. If it exists, plugin stuffs its value under
C<< $t->{t}{body_id} >> (where C<$t> is ZofCMS Template hashref)
otherwise, it creates its own from query's C<dir> and C<page> keys and uses that.

=head1 VALID C<id=""> / PLUGIN'S CHARACTER REPLACEMENT

To quote HTML specification:

    ID and NAME tokens must begin with a letter ([A-Za-z])
    and may be followed by any number of letters,
    digits ([0-9]), hyphens ("-"), underscores ("_"),
    colons (":"), and periods (".").

The plugin replaces any character that doesn't match the criteria with an underscore(C<_>).
Most of the time it will be the slashes (C</>) present in the full page URL.

=head1 GENERATED IDs

After doing invalid character replacement (see above) the plugin prefixes the generated value
with word "C<page>". Considering that any page URL would start with a slash, the resulting
values would be in the form of C<page_index>, C<page_somedir_about-us> and so on.

=head1 HTML::Template VARIABLES

The plugin sets C<body_id> key in C<t> ZofCMS Template special key, thus you can use
C<< <tmpl_var name='body_id'> >> in any of your L<HTML::Template> templates to obtain the
generated ID. The name of the key cannot be changed.

=head1 SEE ALSO

L<App::ZofCMS>, L<App::ZofCMS::Config>, L<App::ZofCMS::Template>, L<http://www.w3.org/TR/html401/types.html#type-name>

=head1 AUTHOR

'Zoffix, C<< <'zoffix at cpan.org'> >>
(L<http://zoffix.com/>, L<http://haslayout.net/>, L<http://zofdesign.com/>)

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
