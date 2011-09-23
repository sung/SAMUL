package Samul::Web;

use strict;
use warnings;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use parent qw/Catalyst/;
use Catalyst qw/-Debug
                ConfigLoader
				Email
                Static::Simple/;
				#AutoCRUD/;
our $VERSION = '0.9';

# Configure the application.
#
# Note that settings in samul_web.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'SAMUL', static=>{ignore_extensions=>[qw/tt tt2 tmpl/]});
#__PACKAGE__->config->{static}->{ignore_extensions} = [qw/tmpl tt tt2/ ];

__PACKAGE__->config->{email} = ['Sendmail'];
# it does not send an email, although it looks successful without 'ssl=>1'
# returns error on 'ssl=>1' 
#__PACKAGE__->config->{email} = ['SMTP','smtp.gmail.com:465',username=>'gong.sungsam',password=>'qkdldh703',ssl=>1];


# Start the application
__PACKAGE__->setup();

=head2 
	# prevent dumping config (e..g password) on the error page
	http://wiki.catalystframework.org/wiki/faq#How_do_I_hide_certain_variables_.28e.g._user.2Fpassword.29_from_the_debug_screen.3F	
=cut
use MRO::Compat;
sub dump_these {
	my $c = shift;
	my @variables = $c->next::method(@_);
	return grep { $_->[0] ne 'Config' } @variables;
}


=head1 NAME

Samul::Web - Catalyst based application

=head1 SYNOPSIS

    script/samul_web_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Samul::Web::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
