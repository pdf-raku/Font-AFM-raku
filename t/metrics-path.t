use Test;
plan 4;
use Font::AFM;

%*ENV<METRICS> = "lib:t/fonts:etc";

my Font::AFM $font;
lives-ok { $font .= new: :name<Ambrosia> }

is $font.FontName, 'Ambrosia';
is $font.Weight, 'Medium', '$font.Weight accessor';

my $sw = $font.stringwidth("Raku");
is $sw, 1631, 'Stringwidth for Raku';

done-testing();