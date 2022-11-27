sub MAIN(Str :$glyphlist = 'etc/glyphlist.txt') {
    my %glyphs;
    my %subset = make-subset();

    for $glyphlist.IO.lines {
        next if /^ '#'/ || /^ $/;
        m:s/^ $<glyph-name>=[<alnum>+] ';' [ $<code-point>=[<xdigit>+] ]+ $/
            or do {
                   warn "unable to parse encoding line: $_";
                   next;
        };
        my $glyph-name = ~ $<glyph-name>;
        if %subset{$glyph-name} {
            my $char = @<code-point>.map({ :16( .Str ).chr }).join;
            with %glyphs{$char} {
                warn "multiple glyph-names for {$char.raku}: $_, $glyph-name"
                    unless $_ eq $glyph-name;
            }
            %glyphs{$char} = $glyph-name;
            %subset{$glyph-name}:delete;
        }
    }

    # additional ad-hoc mappings
    %glyphs<μ> = 'mu';
    %glyphs{0.chr} = '.notdef';
    %subset<.notdef>:delete;
    if %subset {
        warn "unresolved glyph-names: {%subset.keys.sort.join: ', '}";
    }

    say %glyphs.raku;
}

sub make-subset {
    require Font::AFM;
    BEGIN our @CoreFonts = <
        Courier      Courier-Bold     Courier-Oblique    Courier-BoldOblique
        Helvetica    Helvetica-Bold   Helvetica-Oblique  Helvetica-BoldOblique
        Times-Roman  Times-Bold       Times-Italic       Times-BoldItalic
        Symbol
    >;

    my %subset;
    $*ERR.print: "building subset";
    for @CoreFonts -> $name {
        $*ERR.print: ".";
        my $class = Font::AFM.metrics-class: $name;
        %subset{$_}++ for $class.Wx.keys;
    }
    $*ERR.say: "done";
    %subset;
}
