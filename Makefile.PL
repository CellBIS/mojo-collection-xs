use strict;
use warnings;
use ExtUtils::MakeMaker 7.64;

WriteMakefile(
  NAME             => 'Mojo::Collection::XS',
  VERSION_FROM     => 'lib/Mojo/Collection/XS.pm',
  ABSTRACT         => 'Fast XS subclass of Mojo::Collection with XS-based while',
  AUTHOR           => 'Achmad Yusri Afandi <yusrideb@cpan.org>',
  LICENSE          => 'perl',
  MIN_PERL_VERSION => '5.16',

  PREREQ_PM => {Mojolicious => 0,},

  XS     => {'XS.xs' => 'XS.c'},
  OBJECT => '$(O_FILES)',

  META_MERGE => {
    provides  => {'Mojo::Collection::XS' => {file => 'lib/Mojo/Collection/XS.pm', version => '0.2',},},
    resources => {
      repository => {
        type => 'git',
        url  => 'https://github.com/CellBIS/mojo-collection-xs.git',
        web  => 'https://github.com/CellBIS/mojo-collection-xs',
      },
      bugtracker => {web => 'https://github.com/CellBIS/mojo-collection-xs/issues',},
    },
    no_index => {directory => ['test'],},
  },

  META_ADD => {
    resources => {
      repository => {
        type => 'git',
        url  => 'https://github.com/CellBIS/mojo-collection-xs.git',
        web  => 'https://github.com/CellBIS/mojo-collection-xs',
      },
    },
  },
);
