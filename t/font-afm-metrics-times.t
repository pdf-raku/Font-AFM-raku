use Test;
plan 6;
%*ENV<METRICS> = 'etc/Core14_AFMs';

require ::('Font::Metrics::times-roman');
my $metrics = ::('Font::Metrics::times-roman').new;

is_approx $metrics.stringwidth("Perl",1), 1.611;
is_deeply $metrics.BBox<P>, [16, 0, 542, 662], 'BBox data';
is $metrics.Kern<R><V>, -80, 'kern data';
nok ($metrics.Kern<V><X>:exists), 'kern data (missing)';
is $metrics.stringwidth("RVX", :!kern), 2111, 'stringwidth :!kern';
is $metrics.stringwidth("RVX", :kern), 2111 - 80, 'stringwidth :kern';
