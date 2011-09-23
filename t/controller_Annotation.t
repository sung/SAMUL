use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Samul::Web' }
BEGIN { use_ok 'Samul::Web::Controller::Annotation' }

ok( request('/annotation')->is_success, 'Request should succeed' );


