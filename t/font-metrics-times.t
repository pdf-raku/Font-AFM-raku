use Test;
plan 2;
%*ENV<FONTMETRICS> = 'etc/Core14_AFMs';

require Font::Metrics::TimesRoman;

is +@Font::Metrics::TimesRoman::wx, 256, 'wx elems';

sub width(Str $string, Array $wx) {
    [+] $string.ords.map({ $wx[$_] });
}

is_approx  width("Perl", \@Font::Metrics::TimesRoman::wx), 1.611;

