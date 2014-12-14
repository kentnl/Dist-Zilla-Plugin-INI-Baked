use strict;
use warnings;

use Test::More;
use Test::Requires {
  'Dist::Zilla::Util::ExpandINI' => '0.003000',    # Comment copying
};

use Test::DZil;
use Dist::Zilla::Util::Test::KENTNL 1.003001 qw( dztest );
use Path::Tiny;

# ABSTRACT: Test basic thing

my $ini = simple_ini( ['@Basic'], ['INI::Baked'], );
my $new_ini;

subtest "Pass one" => sub {

  my $scratch = dztest();
  $scratch->add_file( 'dist.ini', $ini );
  $scratch->build_ok;
  my $nini = $scratch->test_has_built_file('dist.ini.baked');
  is( ( scalar grep { /;/ } $nini->lines_raw( { chomp => 1 } ) ), 3, 'Three comment lines' );
  ok( ( scalar grep { /Dist::Zilla::PluginBundle::Basic/ } $nini->lines_raw( { chomp => 1 } ) ), 'Expanded lines' );
  ok( ( scalar grep { /INI::Baked/ } $nini->lines_raw( { chomp => 1 } ) ), 'Baked entry' );
  $new_ini = $nini->slurp_raw;
};
subtest "Pass Two" => sub {
  my $scratch = dztest();
  $scratch->add_file( 'dist.ini', $new_ini );
  $scratch->build_ok;

  my $nini = $scratch->test_has_built_file('dist.ini.baked');

  is( ( scalar grep { /;/ } $nini->lines_raw( { chomp => 1 } ) ), 6, 'Three comment lines' );
  ok( ( scalar grep { /Dist::Zilla::PluginBundle::Basic/ } $nini->lines_raw( { chomp => 1 } ) ), 'Expanded lines' );
  ok( ( scalar grep { /INI::Baked/ } $nini->lines_raw( { chomp => 1 } ) ), 'Baked entry' );
};

done_testing;

