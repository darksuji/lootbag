use Moops;

class Passwd::LootBag::Controller::Bag extends Mojolicious::Controller {
    my @items;

    method get() {
        my ($ID) = $self->param('id');

        return $self->render(
            json => {
                items => \@items,
            },
        );
    }

    method empty_bag($class:) {
        @items = ();

        return;
    }
    method add_item($class: $item) {
        push @items, $item;

        return;
    }
}

1;
