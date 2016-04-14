use Moops;

class Passwd::LootBag::Bag extends Mojolicious::Controller {
    method get() {
        my ($ID) = $self->param('id');

        return $self->render(json => {});
    }
}

1;
