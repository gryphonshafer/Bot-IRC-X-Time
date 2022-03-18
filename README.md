# NAME

Bot::IRC::X::Time - Bot::IRC plugin for some time functions

# VERSION

version 1.04

[![test](https://github.com/gryphonshafer/Bot-IRC-X-Time/workflows/test/badge.svg)](https://github.com/gryphonshafer/Bot-IRC-X-Time/actions?query=workflow%3Atest)
[![codecov](https://codecov.io/gh/gryphonshafer/Bot-IRC-X-Time/graph/badge.svg)](https://codecov.io/gh/gryphonshafer/Bot-IRC-X-Time)

# SYNOPSIS

    use Bot::IRC;

    Bot::IRC->new(
        connect => { server => 'irc.perl.org' },
        plugins => ['Time'],
    )->run;

# DESCRIPTION

This [Bot::IRC](https://metacpan.org/pod/Bot%3A%3AIRC) plugin provides some time functions. The following are the
details:

## date \[&lt;time>\]

Returns the current date and time. If an optional timestamp is provided, it'll
return the formatted data and time for that timestamp.

## time

Returns the current timestamp.

## zulu

Exactly like `date` except will return Zulu time.

## str2time &lt;string>

Accepts most reasonable date and time strings and returns timestamps for those
values.

## str2date &lt;string>

Accepts most reasonable date and time strings and returns a formatted date and
time string.

## when was &lt;time>|&lt;string>

Accepts a timestamp or a date and time string and returns a duration string
like: "1 year, 2 months, and 4 hours"

## ago &lt;duration string>

Accepts a duration string like what would be returned from "when was" and
returns a formatted date and time string.

# SEE ALSO

You can look for additional information at:

- [Bot::IRC](https://metacpan.org/pod/Bot%3A%3AIRC)
- [GitHub](https://github.com/gryphonshafer/Bot-IRC-X-Time)
- [MetaCPAN](https://metacpan.org/pod/Bot::IRC::X::Time)
- [GitHub Actions](https://github.com/gryphonshafer/Bot-IRC-X-Time/actions)
- [Codecov](https://codecov.io/gh/gryphonshafer/Bot-IRC-X-Time)
- [CPANTS](http://cpants.cpanauthors.org/dist/Bot-IRC-X-Time)
- [CPAN Testers](http://www.cpantesters.org/distro/T/Bot-IRC-X-Time.html)

# AUTHOR

Gryphon Shafer <gryphon@cpan.org>

# COPYRIGHT AND LICENSE

This software is Copyright (c) 2016-2050 by Gryphon Shafer.

This is free software, licensed under:

    The Artistic License 2.0 (GPL Compatible)
