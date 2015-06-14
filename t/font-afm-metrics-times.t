use Test;
plan 8;
%*ENV<METRICS> = 'etc/Core14_AFMs';

require ::('Font::Metrics::times-roman');
my $metrics = ::('Font::Metrics::times-roman').new;

is_approx $metrics.stringwidth("Perl", 1), 1.611;
is-deeply $metrics.BBox<P>, [16, 0, 542, 662], 'BBox data';
is $metrics.KernData<R><V>, -80, 'kern data';
nok ($metrics.KernData<V><X>:exists), 'kern data (missing)';
is $metrics.stringwidth("RVX", :!kern), 2111, 'stringwidth :!kern';
is $metrics.stringwidth("RVX", :kern), 2111 - 80, 'stringwidth :kern';
is-deeply $metrics.kern("RVX" ), [["R", 667.0, -80], ["VX", 1444.0, 0]], '.kern(:kern)';
is-deeply $metrics.kern("RVX", 12), [["R", 8.004, -0.96], ["VX", 17.328, 0]], '.kern(..., $w))';

