use Test;
plan 5;

%*ENV<METRICS> = 'etc/Core14_AFMs';

require ::('Font::AFM');

my $font;

lives_ok {
   $font = ::('Font::AFM').new("Helvetica")
}, 'Font::AFM.new("Helvetica")' or do {
    diag "Can't find the AFM file for Helvetica";
    skip_rest "Can't find required font";
    exit;
};

is $font<Weight>, 'Medium', '$font<Weight> dereference'; 
is $font.Weight, 'Medium', '$font.Weight accessor'; 

dies_ok {$font.Guff}, 'unknown method - dies';

my $sw = $font.stringwidth("Gisle Aas");
is $sw, 4279, 'Stringwith for Helvetica'
    or diag "The stringwidth of 'Gisle Aas' should be 4279 (it was "~$sw~")";


