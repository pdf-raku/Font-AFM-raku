use Test;
plan 1;
%*ENV<METRICS> = 'etc/Core14_AFMs';

require ::('Font::Metrics::TimesRoman');
my $metrics = ::('Font::Metrics::TimesRoman').new;

is_approx $metrics.stringwidth("Perl",1), 1.611;

