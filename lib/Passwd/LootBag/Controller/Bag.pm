use Moops;

class Passwd::LootBag::Controller::Bag extends Mojolicious::Controller {
    method get() {
        my ($ID) = $self->param('id');

        return $self->render(
            json => {
                items => [ $self->stash('bag_model')->all_items() ],
            },
        );
    }
}

1;
