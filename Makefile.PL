use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => "Mojo::Collection::XS",
  VERSION_FROM => 'lib/Mojo/Collection/XS.pm',
  ABSTRACT     => 'Fast XS subclass of Mojo::Collection with XS-based while',
  AUTHOR       => "Achmad Yusri Afandi <yusrideb\@cpan.org>",
  LICENSE      => 'perl',
  PREREQ_PM    => {'Mojolicious' => 0},
  XS           => {'XS.xs'       => 'XS.c'},
  clean        => {FILES         => 'XS.c XS.o blib'},
);
