package Passwd::LootBag::Bag;
use Mojo::Base 'Mojolicious::Controller';

sub get {
    my ($self) = @_;
    my ($ID) = $self->param('id');

    return $self->render(json => {});
}

1;
