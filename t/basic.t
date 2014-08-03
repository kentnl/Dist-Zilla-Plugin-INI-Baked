use strict;
use warnings;

use Test::More;
use Test::DZil;
use Path::Tiny;

# ABSTRACT: Test basic thing

my $ini = simple_ini( ['@Basic'], ['INI::Baked'], );
my $new_ini;

subtest "Pass one" => sub {
  my $scratch = Path::Tiny->tempdir;

  $scratch->child('dist.ini')->spew_utf8($ini);

  my $tzil = Builder->from_config( { dist_root => $scratch->stringify }, );

  $tzil->build;

  my $ndz  = path( $tzil->tempdir )->child('build');
  my $nini = $ndz->child('dist.ini.baked');

  ok( -e $nini, "Baked file emitted" );

  is( ( scalar grep { /;/ } $nini->lines_raw( { chomp => 1 } ) ), 3, 'Three comment lines' );
  ok( ( scalar grep { /Dist::Zilla::PluginBundle::Basic/ } $nini->lines_raw( { chomp => 1 } ) ), 'Expanded lines' );
  ok( ( scalar grep { /INI::Baked/ } $nini->lines_raw( { chomp => 1 } ) ), 'Baked entry' );
  $new_ini = $nini->slurp_utf8;
};
subtest "Pass Two" => sub {
  my $scratch = Path::Tiny->tempdir;

  $scratch->child('dist.ini')->spew_utf8($new_ini);

  my $tzil = Builder->from_config( { dist_root => $scratch->stringify }, );

  $tzil->build;

  my $ndz  = path( $tzil->tempdir )->child('build');
  my $nini = $ndz->child('dist.ini.baked');

  ok( -e $nini, "Baked file emitted" );

  is( ( scalar grep { /;/ } $nini->lines_raw( { chomp => 1 } ) ), 3, 'Three comment lines' );
  ok( ( scalar grep { /Dist::Zilla::PluginBundle::Basic/ } $nini->lines_raw( { chomp => 1 } ) ), 'Expanded lines' );
  ok( ( scalar grep { /INI::Baked/ } $nini->lines_raw( { chomp => 1 } ) ), 'Baked entry' );
  $new_ini = $nini->slurp_utf8;
};

done_testing;

