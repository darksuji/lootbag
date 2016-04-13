use Moops;
use utf8;

class Passwd::LootBag::Tests::BagAPI extends Test::Class::Moose {
    use Test::Most;
    use Test::Mojo;

    use HTTP::Status qw(:constants);

    use constant APP_CLASS => 'Passwd::LootBag';

    has tester => (is => 'rwp');

    method test_setup($report) {
        $self->next::method;
        $self->_set_tester( Test::Mojo->new($self->APP_CLASS) );
    }
    method test_teardown($report) {
        $self->_set_tester(undef);
        $self->next::method;
    }

    method test_empty_bag($report) {
        $self->_make_empty_bag();

        $self->tester
            ->get_ok('/api/v0/bag/1')
            ->status_is(HTTP_OK)
            ->json_is( {} )
        ;
    }

    method _make_empty_bag() {

    }
}

1;
