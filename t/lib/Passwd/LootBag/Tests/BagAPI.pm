use Moops;
use utf8;

class Passwd::LootBag::Tests::BagAPI extends Test::Class::Moose {
    use Test::Most;
    use Test::Mojo;

    use HTTP::Status qw(:constants);

    use Passwd::LootBag::Controller::Bag;

    use constant APP_CLASS => 'Passwd::LootBag';

    has tester => ( is => 'lazy', clearer => '_clear_tester');

    method _build_tester() {
        return Test::Mojo->new($self->APP_CLASS);
    }

    has bag_model => ( is => 'lazy', clearer => '_clear_bag_model');

    method _build_bag_model() {
        return Passwd::LootBag::Model::Bag->new();
    }

    method test_setup($report) {
        $self->next::method;
        $self->_set_application_bag_model();
    }

    method _set_application_bag_model() {
        $self->tester->app->defaults(bag_model => $self->bag_model);
    }

    method test_teardown($report) {
        $self->_clear_bag_model();
        $self->_clear_tester();
        $self->next::method;
    }

    method test_empty_bag($report) {
        $self->_bag_json_is(
            {
                items => [],
            }
        );
    }

    method _bag_json_is($expected) {
        my $t = $self->tester->get_ok('/api/v0/bag/1');

        $t->status_is(HTTP_OK);
        $t->json_is($expected);
    }

    method test_bag_with_one_item($report) {
        my $item = '/api/v0/items/1';
        $self->_make_bag_with_one_item($item);

        $self->_bag_json_is(
            {
                items => [ $item ],
            }
        );
    }

    method _make_bag_with_one_item($item) {
        $self->bag_model->add_item($item);

        return;
    }
}

1;
