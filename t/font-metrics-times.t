use Test;
plan 13;

require ::('Font::Metrics::times-roman');
my $metrics = ::('Font::Metrics::times-roman').new;

is-approx $metrics.stringwidth("Perl", 1), 1.611;
is-deeply $metrics.BBox<P>, [16, 0, 542, 662], 'BBox data';
is-deeply $metrics.FontBBox, [-168, -218, 1000, 898], 'FontBBox data';
is-deeply $metrics.IsFixedPitch, False;
is-deeply $metrics.UnderlinePosition, -100;
is $metrics.KernData<R><V>, -80, 'kern data';
is  $metrics.Ligature<f><l>, 'fl', 'ligatures';
nok ($metrics.KernData<V><X>:exists), 'kern data (missing)';
is $metrics.stringwidth("RVX", :!kern), 2111, 'stringwidth :!kern';
is $metrics.stringwidth("RVX", :kern), 2111 - 80, 'stringwidth :kern';

is-deeply $metrics.kern("RVX"), (["R", -80, "VX"], 2111 - 80), '.kern(:kern)';
is-deeply $metrics.kern("RVX", 12 ), (["R", -0.96, "VX"], (2111 - 80) * 12 / 1000), '.kern(..., $w))';
dies-ok { $metrics.Blah }, 'unknown property method dies';
