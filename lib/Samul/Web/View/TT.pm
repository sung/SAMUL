package Samul::Web::View::TT;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config({
    INCLUDE_PATH => [
        Samul::Web->path_to( 'root', 'src' ),
        Samul::Web->path_to( 'root', 'src', 'Search' ),
        Samul::Web->path_to( 'root', 'src', 'Jmol' ),
        Samul::Web->path_to( 'root', 'src', 'PDB' ),
        Samul::Web->path_to( 'root', 'src', 'UNIPROT' ),
        Samul::Web->path_to( 'root', 'src', 'Messenger' ),
        Samul::Web->path_to( 'root', 'src', 'SNP' ),
        Samul::Web->path_to( 'root', 'src', 'Anno' ),
        Samul::Web->path_to( 'root', 'lib' ),
        Samul::Web->path_to( 'root', 'lib', 'js' ),
    ],
    PRE_PROCESS  => 'config/main',
    WRAPPER      => 'site/wrapper',
    ERROR        => 'error.tt2',
    TIMER        => 0
});

=head1 NAME

Samul::Web::View::TT - Catalyst TTSite View

=head1 SYNOPSIS

See L<Samul::Web>

=head1 DESCRIPTION

Catalyst TTSite View.

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

