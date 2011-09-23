package Samul::Web::Controller::Root;

use strict;
use warnings;
use XML::Feed;
use parent 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Samul::Web::Controller::Root - Root Controller for Samul::Web

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    #$c->response->body( $c->welcome_message );
	#$c->res->redirect($c->uri_for('/search'));
	$c->stash->{template}='index.tt2';
}

sub default :Path {
    my ( $self, $c ) = @_;
    #$c->response->body( 'Page not found' );
    #$c->response->status(404);

	$c->stash->{comment}='Page not found';
    $c->res->redirect($c->uri_for('/search'), 404);
}

sub about :Local :Args(0) {
    my ( $self, $c ) = @_;
	$c->stash->{template}='about.tt2';
}

=head2 rss
	htp://localhost/rss
	XML RSS generator
	[todo] refactoring (e.g. $c->model(SAMUL::RSS::News) )
=cut
sub rss :Local {
    my ( $self, $c ) = @_;

	# get rss feed data (maybe thru local DBMS)
	my $news=$c->model("SAMUL::News")->search_rs(undef,{order_by=>['id desc']});
	my $last_modified= $news->get_column('created')->max(); # a string (2010-03-12 11:33:26)

	# Meta <channel> information here
	my $feed = XML::Feed->new('RSS');
	$feed->title( $c->config->{name} . ' RSS feed' );
	$feed->base($c->uri_for('/'));
	$feed->link( $c->uri_for('/messenger/news')); # link to the site.
	$feed->description($c->config->{description});
	$feed->author($c->config->{author});
	$feed->language($c->config->{lang});
	$feed->generator($c->config->{rss_generator});

	$c->forward('get_datetime', [$last_modified]);
	$feed->modified($c->stash->{dt});

	# not working
	#$feed->image->title($c->config->{name}.' Logo');
	#$feed->image->url($c->config->{logo});
	#$feed->image->link($c->uri_for('/'));

	# Process the entries
	while( my $entry=$news->next ) {
		my $feed_entry = XML::Feed::Entry->new('RSS');
		$feed_entry->title($entry->title);
		$feed_entry->link( $c->uri_for($entry->link) ) if $entry->link;
		# entry->content object
		$feed_entry->summary($entry->description);
		$c->forward('get_datetime', [$entry->created]);
		$feed_entry->issued($c->stash->{dt});
		$feed->add_entry($feed_entry);
	}

	$c->res->body( $feed->as_xml );

}

sub news :Local :Args(0) {
    my ( $self, $c ) = @_;
	$c->res->redirect($c->uri_for('/messenger/news'));
}


sub get_datetime :Private{
    my ( $self, $c ) = @_;

	my $timestamp=$c->req->args->[0]; 
	#[todo] QC for $timestamp
	my ($date,$time)=split(/\s/, $timestamp);

	my ($year,$month,$day)=	split('-', $date);
	my ($hour,$minute,$second)=	split(':', $time) if $time;

	if($time){
		$c->stash->{dt}=DateTime->new(year=>$year,month=>$month,day=>$day,hour=>$hour,minute=>$minute,second=>$second,time_zone=>$c->config->{time_zone});
	}else{
		$c->stash->{dt}=DateTime->new(year=>$year,month=>$month,day=>$day,time_zone=>$c->config->{time_zone});
	}
}


=head2 end
Attempt to render a view, if needed.
=cut
sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;
	#http://dev.catalyst.perl.org/wiki/gettingstarted/howtos/dynamic_meta_titles_tt
	$c->stash(meta => {});

	#custome error message
	#http://search.cpan.org/~hkclark/Catalyst-Manual-5.8004/lib/Catalyst/Manual/Cookbook.pod#Delivering_a_Custom_Error_Page
	 if ( scalar @{ $c->error } ) {
		$c->stash->{errors}   = $c->error;
		$c->stash->{template} = 'error.tt2';
		$c->forward('Samul::Web::View::TT');
		$c->error(0);
	}

	return 1 if $c->response->status =~ /^3\d\d$/;
	return 1 if $c->response->body;

	unless ( $c->response->content_type ) {
		$c->response->content_type('text/html; charset=utf-8');
	}
	$c->forward('Samul::Web::View::TT');
}

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
