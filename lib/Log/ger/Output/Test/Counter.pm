package Log::ger::Output::Test::Counter;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

sub meta { +{
    v => 2,
} }

sub get_hooks {
    my %plugin_conf = @_;

    if (defined $plugin_conf{counter_get_hooks}) {
        ${ $plugin_conf{counter_get_hooks} }++;
    }

    return {
        create_outputter => [
            __PACKAGE__, # key
            50,          # priority
            sub {        # hook
                my %hook_args = @_; # see Log::ger::Manual::Internals/"Arguments passed to hook"

                my $outputter = sub {
                    if (defined $plugin_conf{counter_outputter}) {
                        ${ $plugin_conf{counter_outputter} }++;
                    }
                };
                [$outputter];
            }],
    };
}

1;
# ABSTRACT: Increase internal counter

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 BEGIN { our $counter_get_hooks; our $counter_outputter }
 use Log::ger::Output "Test::Counter" => (
     counter_get_hooks => \$counter_get_hooks,
     counter_outputter => \$counter_outputter,
 );


=head1 DESCRIPTION

This output is for testing only. Instead of actually outputting something, it
increases counters.


=head1 CONFIGURATION

=head2 counter_get_hooks

Reference to scalar. Will be increased whenever C<get_hooks> is called.

=head2 counter_outputter

Reference to scalar. Will be increased whenever outputter is called.


=head1 SEE ALSO

L<Log::ger>

=cut
