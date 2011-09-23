use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Samul::Web' }
BEGIN { use_ok 'Samul::Web::Controller::SevenRegions' }

ok( request('/sevenregions')->is_success, 'Request should succeed' );


