package Samul::Web::View::Download;

use strict;
use base 'Catalyst::View::Download';

=old
__PACKAGE__->config({
	'stash_key'=>'download',
	'default' => 'text/plain',
});
__PACKAGE__->config->{'content_type'}{'text/plain'} = {
#	'outfile' => 'data.txt',
    'stash_key'   => 'plain',
	'module' => '+Download::Plain',
		};
__PACKAGE__->config->{'content_type'}{'text/csv'} = {
#	'outfile' => 'resmap.csv',
    'stash_key'   => 'csv',
	'module' => '+Download::CSV',
    'quote_char'  => '',
    'escape_char' => '/',
    'sep_char'    => "\t",
    'eol'         => "\n",
		};
=cut
__PACKAGE__->config(
    'stash_key'    => 'download',
    'default'      => 'text/plain',
    'content_type' => {
        'text/csv' => {
			# not working for CSV options (manually modified Catalyst::View::Download::CSV)
    		'stash_key'   => 'csv',
		    'quote_char'  => '',
		    'escape_char' => '/',
		    'sep_char'    => "\t",
		    'eol'         => "\n",
            'module'  => '+Download::CSV',
        },
        'text/plain' => {
    		'stash_key'   => 'plain',
            'module'  => '+Download::Plain',
        },
    },
);


=head1 NAME

Samul::Web::View::Download- Catalyst Download View

=head1 SYNOPSIS

See L<Samul::Web>

=head1 DESCRIPTION

Catalyst Download View.

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

