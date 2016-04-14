use Moops;
use utf8;

class Passwd::LootBag::Model::Bag {
    has items => (
        is      => 'rwp', isa => 'ArrayRef',
        default => sub { [] },
        traits  => ['Array'],
        handles => {
            all_items   => 'elements',
            add_item    => 'push',
        },
    );
}

1;
