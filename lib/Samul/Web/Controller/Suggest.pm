package Samul::Web::Controller::Suggest;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Samul::Web::Controller::Suggest - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

=head2 
	setter for $id_class to run 'auto_complete' which takes only one argument ($id)
=cut

=head2 
	autocompletetion based on prototype javascript
	[%c.prototype.auto_complete_field( 'id', {
=cut
my $id_class;
sub field :Local{
    my ( $self, $c ) = @_;

	# not working ??
	#$c->prototype->auto_complete_stylesheet();

	# SET GLOBAL VARIABLE
	$id_class= $c->req->params->{id_type} if defined $c->req->params->{id_type};
	
	# stash does not work in 'form.tt2'
	# it cannot set value to call java script in form.tt2
	# (e.g. [%auto_url=BLOCK%]/search/suggest_id/[%id_class%][%END%])
	#$c->stash->{id_class}=$id_class;
	#$c->stash->{text}=$text;
	#$c->stash->{template}='Search/form.tt2';

}#end of 'sub field'

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

	# not working
	#$c->forward('field');
	#my $id_class= $c->stash->{id_class} if defined $c->stash->{id_class};

	# not working ??
	# $c->prototype->auto_complete_stylesheet();

	# for  <form id="get_id" in 'search/form.tt2'
	my $text= $c->req->params->{id};
	# or 
	# for <form id="get_keyword" in 'search/form.tt2'
	my $keyword= $c->req->params->{keyword};

	my $db={
		uniprot=>{
			name=>'UNIPROT::Uniprotseq',
			field=>'acc',
			uri=>'uniprot',
		},
		pdb=>{
			name=>'GLORIA::Pdbdat',
			field=>'pdb',
			uri=>'pdb',
		},
		snp=>{
			name=>'SAMUL::Snp2ensg',
			field=>'rs_id',
			uri=>'snp',
		},
		keyword=>{
			name=>'UNIPROT::Uniprotseq',
			field=>'name',
		},
	};

	my ($target,$target_db,$min_char);
	# form_id='get_keyword'
	if(defined $keyword){
		$target=$keyword;
		$target_db='keyword';
		$min_char=length($keyword);
	# form_id='get_id'
	}else{
		$target=$text;
		$min_char=length($target);
		# from auto_complete in 'form.tt2'
		if (defined $id_class){
			$target_db=$id_class;
		# other than auto_complete
		# (e.g from sanitizer in Suggest.pm
		}else{
			$target_db=$c->req->params->{id_type};
		}
	}

	$target=lc$target if $target_db eq 'pdb';
	$target=uc$target if $target_db eq 'uniprot';

	if(defined $target and defined $target_db and $min_char>=3){
		# get total number of matched IDs
		# it's not fast than I thought
		# 'search_like' is faster than 'regexp'
=slow
	    my $count_ref = [$c->model($db->{$target_db}{name})->count(
			{
				#$db->{$target_db}{field}=>{'regexp', "$target"},
				$db->{$target_db}{field}=>{-like=>"%$target%"},
			},
        	{
				select=>[$db->{$target_db}{field}],
	        }
		)];
		my $total=${$count_ref}[0];
=cut

		# in case of calling from form.tt2
		# set mininum number of entries to be displayed
		my $min_dis=10 unless $c->req->params->{call};

		# get matched IDs 
	    my $ref = [$c->model($db->{$target_db}{name})->search(
			{
				$db->{$target_db}{field}=>{ -like=>"%$target%" },
			},
        	{
				select=>[$db->{$target_db}{field}],
	        }
		)];
		#)->slice(0,$min_dis)];

		my $total= @{$ref};
		my ($i,@ids);
		foreach my $rf (@{$ref}){
			my $this=$db->{$target_db}{field};
			push @ids, $rf->$this;
			$i++;
			last if defined $min_dis and $i>=$min_dis;
		}

		# Send results 
		# 1. by Prototype   
		#$c->res->output( $c->prototype->auto_complete_result(\@ids) );

		# 2. by customized results
		if (@ids) {
			# id to be displayed
			my @new_ids;

			# from form.tt2
			if(defined $min_dis){
				# Bold the user's text
				@ids = map { s/($target)/<font color='red'><strong>$1<\/strong><\/font>/g; $_ } @ids;
    			# Make each item an HTML line item
	    		@new_ids = map { "<li>$_</li>" } @ids;

				# append a messge at the end if called from form.tt2
   		 		push @new_ids, "<li>$target<span class='informal'> (show all $total results)</span></li>" if $total>$min_dis;

			# from sanitizer in Search.pm
			}else{
				# <a href="http://malory.bioc.cam.ac.uk:8080/uniprot/A1A250">A<font color='red'><strong>1A25</strong></font>0</a>
				# html link
				my $uri=$db->{$target_db}{uri};
				my @links=map {"$c->uri_for('/$uri/$_')"} @ids;
				foreach my $id (@ids){
					my $hl_id=$id;

					# A<font color='red'><strong>1A25<strong></font>
					$hl_id=~s/$target/<font color='red'><strong>$target<\/strong><\/font>/g;
					# http:///malory.bioc.cam.ac.uk:8080/uniprot/A1A25
					my $link=$c->uri_for("/$uri/$id");

					push @new_ids, "<li><a href='$link'>$hl_id</a></li>";
				}
			}

	    	# Set the output using an unordered list.
    		$c->res->body( '<ul>'.join('',@new_ids).'</ul>' );
		}else{
			#$c->res->output("No entries for $target in $target_db");
			$c->stash->{msg}="No entries for $target in $target_db";
			$c->stash->{template}='customed_err.tt2';
		}# end of if @ids
	}else{
		$c->stash->{template}='Search/form.tt2';
	}# end of 'if(defined $target and defined $target_db)
}#end of 'sub index'

=head1 AUTHOR

Sung Gong

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
