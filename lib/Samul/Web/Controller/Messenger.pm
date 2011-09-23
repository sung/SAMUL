package Samul::Web::Controller::Messenger;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::Messenger - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Samul::Web::Controller::Messenger in Message.');
}

# [todo] popup message using javascript
sub err_msg: Private{
    my ($self, $c) = @_;

	$c->stash->{msg}=$c->req->args->[0];
	$c->stash->{template}='Messenger/customed_err.tt2';
} 

sub email :Local {
    my ( $self, $c ) = @_;

	# get parameters
    $c->stash->{subject}= $c->req->params->{'subject'};
    $c->stash->{sender}= $c->req->params->{'sender'};
    $c->stash->{comment}= $c->req->params->{'comment'};

	#[todo] QC for email address of a sender
	my $to=$c->config->{'admin_to'};
	my $cc=$c->config->{'admin_cc'};

	$c->email(
		header => [
			From    => $c->stash->{sender},
			To      => "$to",
			Cc      => "$cc",
			Subject => $c->stash->{subject}
		],
		#body => $c->view('TT')->render($c,'Messenger/feedback.tt2'),
		body => $c->stash->{comment},
	);

	# Error handing 
	if ( scalar( @{ $c->error } ) ) {
		$c->error(0); # Reset the error condition if you need to
		$c->response->body('Sorry, failed to send your comemnts. Something went wrong!');
	} else {
		$c->response->body('Many thanks for sending your comments. We will get back to you as soon as possible.');
	}
}

=head2 news
	/messenger/news/xx
=cut
sub news :Local{
    my ( $self, $c, $news_id ) = @_;

	$c->stash->{news_id}=$news_id if $news_id;
	# get rss feed data (maybe thru local DBMS)
	$c->stash->{news}=[$c->model("SAMUL::News")->search()];

	$c->stash->{template}='news.tt2';
}

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
