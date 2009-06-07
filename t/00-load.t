use Test::More tests => 2;

BEGIN {
    use_ok('App::ZofCMS');
	use_ok( 'App::ZofCMS::Plugin::HTMLFactory::PageToBodyId' );
}

diag( "Testing App::ZofCMS::Plugin::HTMLFactory::PageToBodyId $App::ZofCMS::Plugin::HTMLFactory::PageToBodyId::VERSION, Perl $], $^X" );
