use Test::More tests => 5;
BEGIN { use_ok('Perl::AtEndOfScope') };

my $v=1;

{
  my $restore=Perl::AtEndOfScope->new( sub{$v=shift}, $v );
  $v++;
  ok $v==2, '$v set';
}

ok $v==1, '$v reset';

eval {
  my $restore=Perl::AtEndOfScope->new( sub{$v=shift}, $v );
  $v++;
  die;
};

ok $v==1, '$v reset after die';

eval {
  my $restore=Perl::AtEndOfScope->new( sub{$v=shift}, $v );
  $v++;
  my $i=0;
  $i=1/$i;
};

ok $v==1, '$v reset after 1/0';

# Local Variables: #
# mode: cperl #
# End: #
