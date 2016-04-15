use Moops;
use utf8;

class Passwd::TestsFor::LootBag::Controller::Bag extends Test::Class::Moose {
    use Test::Most;
    use JSON;

    use Test::MockObject::Extends;

    method test_get_empty_bag($report) {
        my $bag = $self->_make_empty_bag();

        my $res = $bag->get();

        try {
            my $data = from_json($res);
            is_deeply(
                $data,
                {
                    items => [],
                }
            );
        } catch {
            diag "JSON was <$res>";
            die $_;
        }
    }

    method _make_empty_bag() {
        my $bag_model = Test::MockObject->new();
        $bag_model->set_isa('Passwd::LootBag::Model::Bag');
        $bag_model->mock(
            all_items => sub {
                return;
            }
        );

        my $bag = Test::MockObject::Extends->new(
            Passwd::LootBag::Controller::Bag->new()
        );

        $bag->mock(
            stash => sub {
                my ($self, $which) = @_;

                my $stash = {
                    bag_model => $bag_model,
                };

                return $stash unless defined $which;
                return $stash->{$which};
            }
        );
        $bag->mock(
            render => sub {
                my ($self, %what) = @_;
                confess 'Need JSON' unless exists $what{json};

                return to_json($what{json});
            }
        );
        return $bag;
    }
}

1;
