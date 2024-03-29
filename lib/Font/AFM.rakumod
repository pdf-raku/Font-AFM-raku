# This -*- raku -*-  module is a simple parser for Adobe Font Metrics files.

unit class Font::AFM:ver<1.24.10>;

=begin pod

=head2 Name

Font::AFM - Interface to Adobe Font Metrics files

=head2 Synopsis

 use Font::AFM;
 my Font::AFM $h .= core-font: 'Helvetica';
 my $copyright = $h.Notice;
 my $w = $h.Wx<aring>;
 $w = $h.stringwidth("Gisle", 10);

=head2 Description

This module implements the Font::AFM class. Objects of this class are
initialised from an AFM (Adobe Font Metrics) file and allow you to obtain
information about the font and the metrics of the various glyphs in the font.

This module includes built-in metrics classes for the 14 PDF Core Fonts.

Metrics can also be loaded for local AFM files on your system.

All measurements in AFM files are given in terms of units equal to
1/1000 of the scale factor of the font being used. To compute actual
sizes in a document, these amounts should be multiplied by (scale
factor of font)/1000.

=head3 Font Metrics Classes

This module includes built-in classes for the 14 PDF Core Fonts. For example:

    use Font::Metrics::helvetica;
    my $bbox = Font::Metrics::helvetica.FontBBox;

The list of PDF Core Fonts is:

=item Courier Fonts
=item2    Font::Metrics::courier
=item2    Font::Metrics::courier-bold
=item2    Font::Metrics::courier-oblique
=item2    Font::Metrics::courier-boldoblique

=item Helvetica Fonts
=item2    Font::Metrics::helvetica
=item2    Font::Metrics::helvetica-bold
=item2    Font::Metrics::helvetica-oblique
=item2    Font::Metrics::helvetica-boldoblique

=item Times-Roman Fonts
=item2    Font::Metrics::times-roman
=item2    Font::Metrics::times-bold
=item2    Font::Metrics::times-italic
=item2    Font::Metrics::times-bolditalic

=item Symbolic Fonts
=item2    Font::Metrics::symbol
=item2    Font::Metrics::zapfdingbats

=head2 Methods

=end pod

# generated by: cd etc/ && raku make-glyphlist.raku --subset
# see also Font::AFM::Glyphs.all-glyphs, which is not subsetted
constant %Glyphs = {" " => "space", "!" => "exclam", "\"" =>
"quotedbl", "#" => "numbersign", "\$" => "dollar", "\%" =>
"percent", "\&" => "ampersand", "'" => "quotesingle", "(" =>
"parenleft", ")" => "parenright", "*" => "asterisk", "+" =>
"plus", "," => "comma", "-" => "hyphen", "." => "period", "/" =>
"slash", "0" => "zero", "1" => "one", "2" => "two", "3" =>
"three", "4" => "four", "5" => "five", "6" => "six", "7" =>
"seven", "8" => "eight", "9" => "nine", ":" => "colon", ";" =>
"semicolon", "<" => "less", "=" => "equal", ">" => "greater", "?"
=> "question", "\@" => "at", :A("A"), :B("B"), :C("C"), :D("D"),
:E("E"), :F("F"), :G("G"), :H("H"), :I("I"), :J("J"), :K("K"),
:L("L"), :M("M"), :N("N"), :O("O"), :P("P"), :Q("Q"), :R("R"),
:S("S"), :T("T"), :U("U"), :V("V"), :W("W"), :X("X"), :Y("Y"),
:Z("Z"), "[" => "bracketleft", "\\" => "backslash", "]" =>
"bracketright", "^" => "asciicircum", :_("underscore"), "`" =>
"grave", :a("a"), :b("b"), :c("c"), :d("d"), :e("e"), :f("f"),
:g("g"), :h("h"), :i("i"), :j("j"), :k("k"), :l("l"), :m("m"),
:n("n"), :o("o"), :p("p"), :q("q"), :r("r"), :s("s"), :t("t"),
:u("u"), :v("v"), :w("w"), :x("x"), :y("y"), :z("z"), "\{" =>
"braceleft", "|" => "bar", "}" => "braceright", "~" =>
"asciitilde", "¡" => "exclamdown", "¢" => "cent", "£" =>
"sterling", "¤" => "currency", "¥" => "yen", "¦" => "brokenbar",
"§" => "section", "¨" => "dieresis", "©" => "copyright",
:ª("ordfeminine"), "«" => "guillemotleft", "¬" => "logicalnot",
"®" => "registered", "¯" => "macron", "°" => "degree", "±" =>
"plusminus", "²" => "twosuperior", "³" => "threesuperior", "´" =>
"acute", :µ("mu"), "¶" => "paragraph", "·" => "periodcentered",
"¸" => "cedilla", "¹" => "onesuperior", :º("ordmasculine"), "»" =>
"guillemotright", "¼" => "onequarter", "½" => "onehalf", "¾" =>
"threequarters", "¿" => "questiondown", :À("Agrave"),
:Á("Aacute"), :Â("Acircumflex"), :Ã("Atilde"), :Ä("Adieresis"),
:Å("Aring"), :Æ("AE"), :Ç("Ccedilla"), :È("Egrave"), :É("Eacute"),
:Ê("Ecircumflex"), :Ë("Edieresis"), :Ì("Igrave"), :Í("Iacute"),
:Î("Icircumflex"), :Ï("Idieresis"), :Ð("Eth"), :Ñ("Ntilde"),
:Ò("Ograve"), :Ó("Oacute"), :Ô("Ocircumflex"), :Õ("Otilde"),
:Ö("Odieresis"), "×" => "multiply", :Ø("Oslash"), :Ù("Ugrave"),
:Ú("Uacute"), :Û("Ucircumflex"), :Ü("Udieresis"), :Ý("Yacute"),
:Þ("Thorn"), :ß("germandbls"), :à("agrave"), :á("aacute"),
:â("acircumflex"), :ã("atilde"), :ä("adieresis"), :å("aring"),
:æ("ae"), :ç("ccedilla"), :è("egrave"), :é("eacute"),
:ê("ecircumflex"), :ë("edieresis"), :ì("igrave"), :í("iacute"),
:î("icircumflex"), :ï("idieresis"), :ð("eth"), :ñ("ntilde"),
:ò("ograve"), :ó("oacute"), :ô("ocircumflex"), :õ("otilde"),
:ö("odieresis"), "÷" => "divide", :ø("oslash"), :ù("ugrave"),
:ú("uacute"), :û("ucircumflex"), :ü("udieresis"), :ý("yacute"),
:þ("thorn"), :ÿ("ydieresis"), :Ā("Amacron"), :ā("amacron"),
:Ă("Abreve"), :ă("abreve"), :Ą("Aogonek"), :ą("aogonek"),
:Ć("Cacute"), :ć("cacute"), :Č("Ccaron"), :č("ccaron"),
:Ď("Dcaron"), :ď("dcaron"), :Đ("Dcroat"), :đ("dcroat"),
:Ē("Emacron"), :ē("emacron"), :Ė("Edotaccent"), :ė("edotaccent"),
:Ę("Eogonek"), :ę("eogonek"), :Ě("Ecaron"), :ě("ecaron"),
:Ğ("Gbreve"), :ğ("gbreve"), :Ģ("Gcommaaccent"),
:ģ("gcommaaccent"), :Ī("Imacron"), :ī("imacron"), :Į("Iogonek"),
:į("iogonek"), :İ("Idotaccent"), :ı("dotlessi"),
:Ķ("Kcommaaccent"), :ķ("kcommaaccent"), :Ĺ("Lacute"),
:ĺ("lacute"), :Ļ("Lcommaaccent"), :ļ("lcommaaccent"),
:Ľ("Lcaron"), :ľ("lcaron"), :Ł("Lslash"), :ł("lslash"),
:Ń("Nacute"), :ń("nacute"), :Ņ("Ncommaaccent"),
:ņ("ncommaaccent"), :Ň("Ncaron"), :ň("ncaron"), :Ō("Omacron"),
:ō("omacron"), :Ő("Ohungarumlaut"), :ő("ohungarumlaut"), :Œ("OE"),
:œ("oe"), :Ŕ("Racute"), :ŕ("racute"), :Ŗ("Rcommaaccent"),
:ŗ("rcommaaccent"), :Ř("Rcaron"), :ř("rcaron"), :Ś("Sacute"),
:ś("sacute"), :Ş("Scedilla"), :ş("scedilla"), :Š("Scaron"),
:š("scaron"), :Ţ("Tcommaaccent"), :ţ("tcommaaccent"),
:Ť("Tcaron"), :ť("tcaron"), :Ū("Umacron"), :ū("umacron"),
:Ů("Uring"), :ů("uring"), :Ű("Uhungarumlaut"),
:ű("uhungarumlaut"), :Ų("Uogonek"), :ų("uogonek"),
:Ÿ("Ydieresis"), :Ź("Zacute"), :ź("zacute"), :Ż("Zdotaccent"),
:ż("zdotaccent"), :Ž("Zcaron"), :ž("zcaron"), :ƒ("florin"),
:Ș("Scommaaccent"), :ș("scommaaccent"), :ˆ("circumflex"),
:ˇ("caron"), "˘" => "breve", "˙" => "dotaccent", "˚" => "ring",
"˛" => "ogonek", "˜" => "tilde", "˝" => "hungarumlaut",
:Α("Alpha"), :Β("Beta"), :Γ("Gamma"), :Ε("Epsilon"), :Ζ("Zeta"),
:Η("Eta"), :Θ("Theta"), :Ι("Iota"), :Κ("Kappa"), :Λ("Lambda"),
:Μ("Mu"), :Ν("Nu"), :Ξ("Xi"), :Ο("Omicron"), :Π("Pi"), :Ρ("Rho"),
:Σ("Sigma"), :Τ("Tau"), :Υ("Upsilon"), :Φ("Phi"), :Χ("Chi"),
:Ψ("Psi"), :Ω("Omega"), :α("alpha"), :β("beta"), :γ("gamma"),
:δ("delta"), :ε("epsilon"), :ζ("zeta"), :η("eta"), :θ("theta"),
:ι("iota"), :κ("kappa"), :λ("lambda"), :ν("nu"), :ξ("xi"),
:ο("omicron"), :π("pi"), :ρ("rho"), :ς("sigma1"), :σ("sigma"),
:τ("tau"), :υ("upsilon"), :φ("phi"), :χ("chi"), :ψ("psi"),
:ω("omega"), :ϑ("theta1"), :ϒ("Upsilon1"), :ϕ("phi1"),
:ϖ("omega1"), "–" => "endash", "—" => "emdash", "‘" =>
"quoteleft", "’" => "quoteright", "‚" => "quotesinglbase", "“" =>
"quotedblleft", "”" => "quotedblright", "„" => "quotedblbase", "†"
=> "dagger", "‡" => "daggerdbl", "•" => "bullet", "…" =>
"ellipsis", "‰" => "perthousand", "′" => "minute", "″" =>
"second", "‹" => "guilsinglleft", "›" => "guilsinglright", "⁄" =>
"fraction", "€" => "Euro", :ℑ("Ifraktur"), "℘" => "weierstrass",
:ℜ("Rfraktur"), "™" => "trademark", :ℵ("aleph"), "←" =>
"arrowleft", "↑" => "arrowup", "→" => "arrowright", "↓" =>
"arrowdown", "↔" => "arrowboth", "↵" => "carriagereturn", "⇐" =>
"arrowdblleft", "⇑" => "arrowdblup", "⇒" => "arrowdblright", "⇓"
=> "arrowdbldown", "⇔" => "arrowdblboth", "∀" => "universal", "∂"
=> "partialdiff", "∃" => "existential", "∅" => "emptyset", "∆" =>
"Delta", "∇" => "gradient", "∈" => "element", "∉" => "notelement",
"∋" => "suchthat", "∏" => "product", "∑" => "summation", "−" =>
"minus", "∗" => "asteriskmath", "√" => "radical", "∝" =>
"proportional", "∞" => "infinity", "∠" => "angle", "∧" =>
"logicaland", "∨" => "logicalor", "∩" => "intersection", "∪" =>
"union", "∫" => "integral", "∴" => "therefore", "∼" => "similar",
"≅" => "congruent", "≈" => "approxequal", "≠" => "notequal", "≡"
=> "equivalence", "≤" => "lessequal", "≥" => "greaterequal", "⊂"
=> "propersubset", "⊃" => "propersuperset", "⊄" => "notsubset",
"⊆" => "reflexsubset", "⊇" => "reflexsuperset", "⊕" =>
"circleplus", "⊗" => "circlemultiply", "⊥" => "perpendicular", "⋅"
=> "dotmath", "⌠" => "integraltp", "⌡" => "integralbt", "◊" =>
"lozenge", "♠" => "spade", "♣" => "club", "♥" => "heart", "♦" =>
"diamond", "〈" => "angleleft", "〉" => "angleright", "" =>
"commaaccent", "" => "copyrightserif", "" => "registerserif",
"" => "trademarkserif", "" => "radicalex", "" => "arrowvertex",
"" => "arrowhorizex", "" => "registersans", "" =>
"copyrightsans", "" => "trademarksans", "" => "parenlefttp", ""
=> "parenleftex", "" => "parenleftbt", "" => "bracketlefttp",
"" => "bracketleftex", "" => "bracketleftbt", "" =>
"bracelefttp", "" => "braceleftmid", "" => "braceleftbt", "" =>
"braceex", "" => "integralex", "" => "parenrighttp", "" =>
"parenrightex", "" => "parenrightbt", "" => "bracketrighttp",
"" => "bracketrightex", "" => "bracketrightbt", "" =>
"bracerighttp", "" => "bracerightmid", "" => "bracerightbt", ""
=> "apple", :ﬁ("fi"), :ﬂ("fl"), :mu("μ"), 0.chr => ".notdef" };

has Hash:D $.glyphs = %Glyphs;
multi method glyphs(::?CLASS:D:) is rw { $!glyphs }
multi method glyphs(::?CLASS:U:) { %Glyphs }

#| Loads a named PDF core font
method core-font(Str $font-name, |c --> Font::AFM:D) {
    my ::?CLASS:U $class = self.metrics-class($font-name);
    $class.new: |c;
}
=para Where `$font-name` is one of `Helvetica`, `Helvetica-Bold`, `Helvetica-Oblique`, `Helvetica-Boldoblique`, `Times-Roman`, `Times-Bold`, `Times-Italic`, `Times-BoldItalic`, `Symbol`, or `Zapfdingbats` (case insensitive).

=begin pod

=head3 my $afm = Font::AFM.new: :$name;

AFM font metrics loader. `:$name` may be the absolute path of a font.
Otherwise the font is loaded from the directory specified by the
`METRICS` environment variable (see ENVIRONMENT below). Croaks if the font can not be found.

=head3 $afm.FontName

The name of the font as presented to the PostScript language
C<findfont> operator, for instance "Times-Roman".

=head3 $afm.FullName

Unique, human-readable name for an individual font, for instance
"Times Roman".

=head3 $afm.FamilyName

Human-readable name for a group of fonts that are stylistic variants
of a single design. All fonts that are members of such a group should
have exactly the same C<FamilyName>. Example of a family name is
"Times".

=head3 $afm.Weight

Human-readable name for the weight, or "boldness", attribute of a font.
Examples are C<Roman>, C<Bold>, C<Light>.

=head3 $afm.ItalicAngle

Angle in degrees counterclockwise from the vertical of the dominant
vertical strokes of the font.

=head3 $afm.IsFixedPitch

If C<true>, the font is a fixed-pitch
(monospaced) font.

=head3 $afm.FontBBox

An array of integers giving the lower-left x, lower-left y,
upper-right x, and upper-right y of the font bounding box in
relation to its origin. The font
bounding box is the smallest rectangle enclosing the shape that would
result if all the characters of the font were placed with their
origins coincident, and then painted.

=head3 $afm.KernData

A two dimensional hash containing from and to glyphs and kerning widths.

=head3 $afm.UnderlinePosition

Recommended distance from the baseline for positioning underline
strokes. This number is the y coordinate of the center of the stroke.

=head3 $afm.UnderlineThickness

Recommended stroke width for underlining.

=head3 $afm.Version

Version number of the font.

=head3 $afm.Notice

Trademark or copyright notice, if applicable.

=head3 $afm.Comment

Comments found in the AFM file.

=head3 $afm.EncodingScheme

The name of the standard encoding scheme for the font. Most Adobe
fonts use the C<AdobeStandardEncoding>. Special fonts might state
C<FontSpecific>.

=head3 $afm.CapHeight

Usually the y-value of the top of the capital H.

=head3 $afm.XHeight

Typically the y-value of the top of the lowercase x.

=head3 $afm.Ascender

Typically the y-value of the top of the lowercase d.

=head3 $afm.Descender

Typically the y-value of the bottom of the lowercase p.

=head3 $afm.Wx

Returns a hash table that maps from glyph names to the width of that glyph.

=head3 $afm.BBox

Returns a hash table that maps from glyph names to bounding box information
in relation to each glyph's origin.
The bounding box consist of four numbers: llx, lly, urx, ury.

=head3 $afm.stringwidth($string, $fontsize?, :kern, :%glyphs)

Returns the width of the string passed as argument. The
string is assumed to contains only characters from `%glyphs`
A second argument can be used to scale the width according to
the font size.

=head3 ($kerned, $width) = $afm.kern($string, $fontsize?, :%glyphs?)

Kern the string. Returns an array of string segments, separated
by numeric kerning distances, and the overall width of the string.

       :%glyphs            - an optional mapping of characters to glyph-names.

=head2 SEE ALSO

=item L<Font::FreeType> - To obtain metrics (and more) for many other font formats , including`*.pfa`, `*.pfm`, `*.ttf` and `*.otf` files.

=item L<HarfBuzz> - Also has some ability to obtain metrics for `*.ttf` and `*.otf` fonts.

=end pod

#-------Raku resumes here--------------------------------------------

constant UnitsPerEM is export(:UnitsPerEM) = 1000;

has %.metrics;
# Creates a new Font::AFM object from an AFM file.  Pass it the name of the
# font as parameter.
# Synopisis:
#
#    $h = Font::AFM.new: :name<Helvetica>;
#

my Lock $lock .= new;

method class-name(Str $font-name --> Str) {
    [~] "Font::Metrics::", $font-name.lc.subst( /['.afm'$]/, '');
}

#| autoloads the appropriate delegate for the named font. A subclass of Font::AFM
method metrics-class(Str $font-name --> Font::AFM:U) {
    my $class-name = self.class-name($font-name);
    $lock.protect: { require ::($class-name); }
}

submethod TWEAK( Str :$name, Bool :$build) {
    with $name {
        if !$build && .lc ~~ m:i/^['courier'|'courier-bold'|'courier-oblique'|'courier-boldoblique'|'helvetica'|'helvetica-bold'|'helvetica-oblique'|'helvetica-boldoblique'|'times-roman'|'times-bold'|'times-italic'|'times-bolditalic'|'symbol'|'zapfdingbats']'.afm'?$/ {
            # standard core font
            %!metrics = self.metrics-class($_).metrics;
        }
        else {
            self!load-afm-metrics($_);
        }
    }
}

# full list of properties
# see https://www.adobe.com/content/dam/acom/en/devnet/font/pdfs/5004.AFM_Spec.pdf
constant %Props = %(
     :FontName(Str), :FullName(Str), :FamilyName(Str),:Weight(Str), :ItalicAngle(Num),
     :IsFixedPitch(Bool), :FontBBox(Array[Int]), :UnderlinePosition(Int), :UnderlineThickness(Int),
     :Version(Version), :Notice(Str), :Comment(Str), :EncodingScheme(Str), :CapHeight(Int),
     :XHeight(Int), :Ascender(Int), :Descender(Int), :StdHw(Num), :StdVW(Num),
     :MappingScheme(Int), :EscChar(Int), :CharacterSet(Str), :Characters(Str), :IsBaseFont(Bool),
     :VVector(Array[Num]), :IsFixedV(Bool), :IsCIDFont(Bool), :CharWidth(Num)
);

method !coerce(Str $key, Str $val) {
    %Props{$key}:exists
        ?? do given %Props{$key} {
            when $val ~~ $_ { $val }
            when Bool       { $val ~~ 'true' }
            when Int        { $val.Int }
            when Num        { $val.Num }
            when Array[Int] { [ $val.comb(/[<[+-]>|\w|"."]+/)».Int ] }
            when Array[Num] { [ $val.comb(/[<[+-]>|\w|"."]+/)».Num ] }
            when Version    { Version.new($val) }
            default { warn "don't know how to convert $key:{$val.raku} of type {.raku}"; $val }
        }
        !! $val
}

method !load-afm-metrics(Str $name) is hidden-from-backtrace {
   %!metrics = ( :BBox{}, :KernData{}, :Ligature{}, :Wx{}, );

   my $file = $name;

   unless $*SPEC.is-absolute($file) {
      $file ~= '.afm'
          unless $file.ends-with('.afm');
       # not absolute, search the metrics path for the file
       my @metrics-path = do with %*ENV<METRICS> {
           .split(/\:/)>>.subst(rx{'/'$},'')
       }
       else {
           < /usr/lib/afm  /usr/local/lib/afm
             /usr/openwin/lib/fonts/afm  . >;
       }
       $file = $_
           with (@metrics-path\
                 .map({ $*SPEC.catfile( $_, $file) })\
                 .first: { .IO ~~ :f });
   }

   die "Can't find the AFM file for $name ($file)"
       unless $file.IO ~~ :e;

   my $afm = $file.IO.open( :r );

   for $afm.lines {

       if /^StartKernData/ ff /^EndKernData/ {
           next unless m:s/ <|w> KPX  $<glyph1>=['.'?\w+] $<glyph2>=['.'?\w+] $<kern>=[< + - >?\d+] /;
           %!metrics<KernData>{ $<glyph1> }{ $<glyph2> } = $<kern>.Int;
           next;
       }
       next if /^StartComposites/ ff /^EndComposites/; # same for composites
       if /^StartCharMetrics/     ff /^EndCharMetrics/ {
           # only lines that start with "C" or "CH" are parsed
           next unless /^ CH? ' ' /;
           my Str $name  = ~ m:s/ <|w> N <(<[ \x21..\x7F ]>+)> ';' /;
           my Numeric $wx    = + m:s/ <|w> WX <(\d+)>     ';' /;
           warn "no bbox: $_"
               unless m:s/ <|w> B [ (< + - >?\d+) ]+ ';' /;
           my Array $bbox = [ @0».Int ];
           %!metrics<Wx>{$name} = $wx;
           %!metrics<BBox>{$name} = $bbox;
           # Ligatures
           for .comb(rx:s/ L <ident> <ident> ';' /) {
               if m:s/ L <succ=.ident> <lig=.ident> / {
                   %!metrics<Ligature>{$name}{$<succ>.Str} = $<lig>.Str;
               }
           }
           next;
       }

       last if /^EndFontMetrics/;

       if /(^\w+)' '+(.*)/ {
           my Str $key = ~ $0;
           my Str $val = ~ $1;
           if %!metrics{$key} ~~ Str {
               %!metrics{$key} ~= "\n" ~ self!coerce($key, $val);
           }
           else {
               %!metrics{$key} = self!coerce($key, $val);
           }
       } else {
           die "Can't parse: $_";
       }
   }

   $afm.close;

   unless %!metrics<Wx><.notdef>:exists {
       %!metrics<Wx><.notdef> = 0;
       %!metrics<BBox><.notdef> = [ 0, 0, 0, 0];
   }
}

method ligature-subs(|c)  is hidden-from-backtrace {
       $.to-ligature: |c;
}

method to-ligature(Str:D $s is copy) {
    with $.Ligature {
        with .<f> {
            $s .= subst("fi", "ﬁ", :g) if .<i> ~~ 'fi';
            $s .= subst("fl", "ﬂ", :g) if .<l> ~~ 'fl';
            $s .= subst("ff", "ﬀ", :g) if .<f> ~~ 'ff';
    }   }
    $s;
}

method from-ligature(Str:D $s is copy) {
    with $.Ligature {
        with .<f> {
            $s .= subst("ﬁ", "fi", :g) if .<i> ~~ 'fi';
            $s .= subst("ﬂ", "fl", :g) if .<l> ~~ 'fl';
            $s .= subst("ﬀ", "fl", :g) if .<f> ~~ 'ff';
        }

    }
    $s;
}

# compute the expected string-width at the given point size for this glyph set
method stringwidth( Str $string,
                    Numeric $pointsize?,
                    Bool :$kern,                        # including kerning adjustments
                    Hash :$glyphs = $.glyphs,
    --> Numeric ) {
    my Numeric $width = 0.0;
    my Str $prev-glyph;
    my Hash $kern-data;
    if $kern {
        $kern-data = $_ with self.KernData;
    }
    my Hash $wx = self.Wx;

    for $string.comb {
        my Str $glyph-name = $glyphs{$_} // next;
        $width += $wx{$glyph-name} // next;

        with $kern-data {
            with $prev-glyph && .{$prev-glyph} {
                $width += $_ with .{$glyph-name};
            }
            $prev-glyph = $glyph-name;
        }
    }
    if ($pointsize) {
        $width *= $pointsize / UnitsPerEM;
    }
    $width;
}

# kern a string. decompose into an array of: ('string1', $kern , ..., 'stringn' )
method kern( Str $string,
             Numeric $pointsize?,
             Hash :$glyphs = %Glyphs
    --> List ) {
    my Str $prev-glyph;
    my Str $str = '';
    my Numeric $stringwidth = 0;
    my @chunks;
    my Hash $kern-data = $_
        with self.KernData;
    my Hash $wx = self.Wx;

    for $string.comb {
        my Str $glyph-name = $glyphs{$_} // next;
        $stringwidth += $wx{$glyph-name} // next;

        with $kern-data {
            with $prev-glyph && .{$prev-glyph} {
                with .{$glyph-name} -> $kerning is copy {
                    $stringwidth += $kerning;
                    $kerning *= $pointsize / UnitsPerEM
                        if $pointsize;
                    @chunks.push: $str;
                    @chunks.push: $kerning;
                    $str = '';
                }
            }
            $prev-glyph = $glyph-name;
        }

        $str ~= $_;
    }

    @chunks.push: $str
        if $str;

    $stringwidth *= $pointsize / UnitsPerEM
        if $pointsize;

    @chunks, $stringwidth;
}

method Wx { $.metrics<Wx> }
method BBox { $.metrics<BBox> }
method KernData { $.metrics<KernData> }
method Ligature { $.metrics<Ligature> }

method !is-prop(Str $prop-name --> Bool) {
    %Props{$prop-name}:exists;
}

method raku-gen(:$name = self.^name) {
    qq:to<--END-->
    class $name \{

        use Font::AFM;
        also is Font::AFM;

        constant Data = {$.metrics.raku};
        method metrics \{ Data \}
    \}
    --END--
}

method dispatch:<.?>(\name, |c) is raw {
    self.can(name) || (%Props{name}:exists)
        ?? self."{name}"(|c) 
        !! Nil
}

method FALLBACK(Str $method, |c) {
    %Props{$method}:exists
        ?? $.metrics{$method} // %Props{$method}
        !! die X::Method::NotFound.new( :$method, :typename(self.^name) );
}

=begin pod

The AFM specification can be found at:

   http://partners.adobe.com/asn/developer/pdfs/tn/5004.AFM_Spec.pdf

=head1 ENVIRONMENT

=begin item

I<METRICS>

Contains the path to search for AFM-files.  Format is as for the PATH
environment variable. The default path built into this library is:

 /usr/lib/afm:/usr/local/lib/afm:/usr/openwin/lib/fonts/afm/:.

=end item


=head1 BUGS

Composite character and Ligature data are not parsed.


=head1 COPYRIGHT

Copyright 1995-1998 Gisle Aas. All rights reserved.

Ported from Perl to Raku by David Warring Copyright 2015

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=end pod

