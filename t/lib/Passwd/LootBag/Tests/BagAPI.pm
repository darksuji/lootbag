use Moops;
use utf8;

class Passwd::LootBag::Tests::BagAPI extends Test::Class::Moose {
    use Test::Most;
    use Test::Mojo;

    use HTTP::Status qw(:constants);

    use Passwd::LootBag::Controller::Bag;

    use constant APP_CLASS => 'Passwd::LootBag';

    has tester => (is => 'rwp');

    method test_setup($report) {
        $self->next::method;
        $self->_set_tester( Test::Mojo->new($self->APP_CLASS) );
        $self->_make_empty_bag();
    }

    method test_teardown($report) {
        $self->_set_tester(undef);
        $self->next::method;
    }

    method test_empty_bag($report) {
        my $t = $self->tester->get_ok('/api/v0/bag/1');

        $t->status_is(HTTP_OK);
        $t->json_is(
            {
                items => [],
            }
        );
    }

    method _make_empty_bag() {
        $self->_bag_model->empty_bag();
    }

    has _bag_model => (is => 'rwp', default => 'Passwd::LootBag::Controller::Bag');

    method test_bag_with_one_item($report) {
        my $item = '/api/v0/items/1';
        $self->_make_bag_with_one_item($item);

        my $t = $self->tester->get_ok('/api/v0/bag/1');

        $t->status_is(HTTP_OK);
        $t->json_is(
            {
                items => [ $item ],
            }
        );
    }

    method _make_bag_with_one_item($item) {
        $self->_bag_model->add_item($item);

        return;
    }
}

1;
