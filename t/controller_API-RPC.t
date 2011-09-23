use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Samul::Web' }
BEGIN { use_ok 'Samul::Web::Controller::API::RPC' }

ok( request('/api/rpc')->is_success, 'Request should succeed' );


