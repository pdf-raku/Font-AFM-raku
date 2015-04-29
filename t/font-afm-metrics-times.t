use Test;
plan 1;
%*ENV<METRICS> = 'etc/Core14_AFMs';

require ::('Font::Metrics::times-roman');
my $metrics = ::('Font::Metrics::times-roman').new;

is_approx $metrics.stringwidth("Perl",1), 1.611;

