use Moops;
use utf8;

class Passwd::LootBag::Tests::BagAPI extends Test::Class::Moose {
    use Test::Most;
    use Test::Mojo;

    use HTTP::Status qw(:constants);

    use constant APP_CLASS => 'Passwd::LootBag';

    has UA => (is => 'rwp');

    method test_setup($report) {
        $self->next::method;
        $self->_set_UA( Test::Mojo->new($self->APP_CLASS) );
    }
    method test_teardown($report) {
        $self->_set_UA(undef);
        $self->next::method;
    }

    method test_empty_bag($report) {
        $self->_make_empty_bag();

        $self->UA
            ->get_ok('/api/v0/bag/1')
            ->status_is(HTTP_OK)
            ->json_is( {} )
        ;
    }
}

1;
