package Bot::IRC::X::Time;
# ABSTRACT: Bot::IRC plugin for some time functions

use 5.012;
use strict;
use warnings;

use Date::Parse 'str2time';
use DateTime;
use DateTime::Format::Human::Duration;
use DateTime::Duration;

# VERSION

sub init {
    my ($bot) = @_;

    my $duration = DateTime::Format::Human::Duration->new;
    $bot->hook(
        {
            to_me => 1,
            text  => qr/
                ^(?<command>date|time|zulu|str2time|str2date|when\s+(?:wa|i)s|ago)
                \b\s*(?<input>.+)?[.,;:?!]*$
            /ix,
        },
        sub {
            my ( $bot, $in, $m ) = @_;
            my $command = lc( $m->{command} );

            my $reply = '';
            if ( $command eq 'date' ) {
                $reply = scalar( localtime( $m->{input} || time ) );
            }
            elsif ( $command eq 'time' ) {
                $reply = time();
            }
            elsif ( $command eq 'zulu' ) {
                $reply = scalar( gmtime( $m->{input} || time ) );
            }
            elsif ( $command eq 'str2time' ) {
                $reply = str2time( $m->{input} );
            }
            elsif ( $command eq 'str2date' ) {
                $reply = scalar( localtime( str2time( $m->{input} ) ) );
            }
            elsif ( $command eq 'ago' ) {
                $reply = scalar( localtime( DateTime->now->subtract_duration(
                    DateTime::Duration->new(
                        map {
                            $_ . 's' => ( ( $m->{input} =~ /\b(\d+)\s+$_/ ) ? $1 : 0 )
                        } qw( year month week day hour minute second )
                    )
                )->epoch ) );
            }
            elsif ( $command =~ /when\s+((?:wa|i)s)/i ) {
                my $dir   = ( lc($1) eq 'was' ) ? 'was' : 'is';
                my $start = str2time( $m->{input} ) || $m->{input};
                my $dur;

                eval {
                    $dur = $duration->format_duration_between(
                        map { DateTime->from_epoch( epoch => $_ ) } $start, time
                    )
                };

                $reply = scalar( localtime($start) ) . " $dir $dur " .
                    ( ( $dir eq 'was' ) ? 'ago' : 'from now' ) . '.' if ($dur);
            }

            $bot->reply_to($reply) if ($reply);
        },
    );

    $bot->helps( time =>
        'Various time functions. Usage: ' . join( ', ',
            'date',
            'time',
            'zulu',
            'str2time <string>',
            'str2date <string>',
            'when was <time>|<"ago" string>',
            'ago <time>|<string>',
        ) . '.'
    );
}

1;
__END__
=pod

=begin :badges

=for markdown
[![Build Status](https://travis-ci.org/gryphonshafer/Bot-IRC-X-Time.svg)](https://travis-ci.org/gryphonshafer/Bot-IRC-X-Time)
[![Coverage Status](https://coveralls.io/repos/gryphonshafer/Bot-IRC-X-Time/badge.png)](https://coveralls.io/r/gryphonshafer/Bot-IRC-X-Time)

=end :badges

=head1 SYNOPSIS

    use Bot::IRC;

    Bot::IRC->new(
        connect => { server => 'irc.perl.org' },
        plugins => ['Time'],
    )->run;

=head1 DESCRIPTION

This L<Bot::IRC> plugin provides some time functions. The following are the
details:

=head2 date [<time>]

Returns the current date and time. If an optional timestamp is provided, it'll
return the formatted data and time for that timestamp.

=head2 time

Returns the current timestamp.

=head2 zulu

Exactly like C<date> except will return Zulu time.

=head2 str2time <string>

Accepts most reasonable date and time strings and returns timestamps for those
values.

=head2 str2date <string>

Accepts most reasonable date and time strings and returns a formatted date and
time string.

=head2 when was <time>|<string>

Accepts a timestamp or a date and time string and returns a duration string
like: "1 year, 2 months, and 4 hours"

=head2 ago <duration string>

Accepts a duration string like what would be returned from "when was" and
returns a formatted date and time string.

=head1 SEE ALSO

You can look for additional information at:

=for :list
* L<Bot::IRC>
* L<GitHub|https://github.com/gryphonshafer/Bot-IRC-X-Time>
* L<CPAN|http://search.cpan.org/dist/Bot-IRC-X-Time>
* L<MetaCPAN|https://metacpan.org/pod/Bot::IRC::X::Time>
* L<AnnoCPAN|http://annocpan.org/dist/Bot-IRC-X-Time>
* L<Travis CI|https://travis-ci.org/gryphonshafer/Bot-IRC-X-Time>
* L<Coveralls|https://coveralls.io/r/gryphonshafer/Bot-IRC-X-Time>
* L<CPANTS|http://cpants.cpanauthors.org/dist/Bot-IRC-X-Time>
* L<CPAN Testers|http://www.cpantesters.org/distro/T/Bot-IRC-X-Time.html>

=for Pod::Coverage init

=cut
