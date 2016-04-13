package Passwd::LootBag;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my ($self) = @_;

  # Router
  my $r = $self->routes;

  $r->get('/api/v0/bag/:id')->to(controller => 'Bag', action => 'get');
}

1;
