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

        my $t = $self->tester->get_ok('/api/v0/bag/1');

        $t->status_is(HTTP_OK);
        $t->json_is( {} );
    }

    method _make_empty_bag() {

    }

    method test_bag_with_one_item($report) {
        $self->_make_bag_with_one_item();

        my $t = $self->tester->get_ok('/api/v0/bag/1');

        $t->status_is(HTTP_OK);
        $t->json_is(
            {
                items => [
                    '/api/v0/items/1'
                ],
            }
        );
    }

    method _make_bag_with_one_item() {
        my $bag = $self->_make_empty_bag();

        return $bag;
    }
}

1;
