# This -*- perl6 -*-  module is a simple parser for Adobe Font Metrics files.

class Font::AFM:vers<1.20>
    is Hash;

=begin pod

=head1 NAME

Font::AFM - Interface to Adobe Font Metrics files

=head1 SYNOPSIS

 use Font::AFM;
 my $h = Font::AFM.new('Helvetica');
 my $copyright = $h.Notice;
 my $w = $h.Wx<aring>;
 $w = $h.stringwidth("Gisle", 10);
 $h.dump;  # for debugging

=head1 DESCRIPTION

This module implements the Font::AFM class. Objects of this class are
initialised from an AFM (Adobe Font Metrics) file and allow you to obtain information
about the font and the metrics of the various glyphs in the font.

All measurements in AFM files are given in terms of units equal to
1/1000 of the scale factor of the font being used. To compute actual
sizes in a document, these amounts should be multiplied by (scale
factor of font)/1000.

The following methods are available:

=over 3

=item my $afm = Font::AFM.new($fontname)

Object constructor. Takes the name of the font as argument.
Croaks if the font can not be found.

=item $afm.wx-table('latin1')

Returns a 256-element array, where each element contains the width
of the corresponding character in the latin1 character set.

=item $afm.stringwidth($string, [$fontsize])

Returns the width of the argument string. A second
argument can be used to scale the width according to the font size.

=item $afm.FontName

The name of the font as presented to the PostScript language
C<findfont> operator, for instance "Times-Roman".

=item $afm.FullName

Unique, human-readable name for an individual font, for instance
"Times Roman".

=item $afm.FamilyName

Human-readable name for a group of fonts that are stylistic variants
of a single design. All fonts that are members of such a group should
have exactly the same C<FamilyName>. Example of a family name is
"Times".

=item $afm.Weight

Human-readable name for the weight, or "boldness", attribute of a font.
Examples are C<Roman>, C<Bold>, C<Light>.

=item $afm.ItalicAngle

Angle in degrees counterclockwise from the vertical of the dominant
vertical strokes of the font.

=item $afm.IsFixedPitch

If C<true>, the font is a fixed-pitch
(monospaced) font.

=item $afm.FontBBox

An array of integers giving the lower-left x, lower-left y,
upper-right x, and upper-right y of the font bounding box. The font
bounding box is the smallest rectangle enclosing the shape that would
result if all the characters of the font were placed with their
origins coincident, and then painted.

=item $afm.Kern

A two dimenionsal hash of from and two glyphs and kerning adjustment.

=item $afm.UnderlinePosition

Recommended distance from the baseline for positioning underline
strokes. This number is the y coordinate of the center of the stroke.

=item $afm.UnderlineThickness

Recommended stroke width for underlining.

=item $afm.Version

Version number of the font.

=item $afm.Notice

Trademark or copyright notice, if applicable.

=item $afm.Comment

Comments found in the AFM file.

=item $afm.EncodingScheme

The name of the standard encoding scheme for the font. Most Adobe
fonts use the C<AdobeStandardEncoding>. Special fonts might state
C<FontSpecific>.

=item $afm.CapHeight

Usually the y-value of the top of the capital H.

=item $afm.XHeight

Typically the y-value of the top of the lowercase x.

=item $afm.Ascender

Typically the y-value of the top of the lowercase d.

=item $afm.Descender

Typically the y-value of the bottom of the lowercase p.

=item $afm.Wx

Returns a hash table that maps from glyph names to the width of that glyph.

=item $afm.BBox

Returns a hash table that maps from glyph names to bounding box information.
The bounding box consist of four numbers: llx, lly, urx, ury.

=back

The AFM specification can be found at:

   http://partners.adobe.com/asn/developer/pdfs/tn/5004.AFM_Spec.pdf


=head1 ENVIRONMENT

=over 10

=item METRICS

Contains the path to search for AFM-files.  Format is as for the PATH
environment variable. The default path built into this library is:

 /usr/lib/afm:/usr/local/lib/afm:/usr/openwin/lib/fonts/afm/:.

=back


=head1 BUGS

Composite character and Ligature data are not parsed.


=head1 COPYRIGHT

Copyright 1995-1998 Gisle Aas. All rights reserved.

Ported from Perl 5 to 6 by David Warring Copyright 2015

This program is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=end pod

#-------perl 6 resumes here--------------------------------------------

method class-name($font-name) {
    [~] "Font::Metrics::", $font-name.subst( /[:i'.afm'$]/, '').lc;
}

method core-font($font-name) {
    my $class-name = self.class-name($font-name);
    require ::($class-name);
    ::($class-name).new;
}

# Creates a new Font::AFM object from an AFM file.  Pass it the name of the
# font as parameter.
# Synopisis:
#
#    $h = Font::AFM.new("Helvetica");
#

use Font::Encoding;

multi submethod BUILD( Str :$name! is copy) {

   my $metrics = {};

   $name ~~ s/'.afm' $//;
   my $file;

  if ~$*DISTRO ~~ m:i{^VMS} {
       # Perl 5 porters note: Perl 6 on VMS?
       $file = [~] 'sys$ps_font_metrics:', $name, '.afm';
   } else {
       $file = $name ~ '.afm';
       unless $*SPEC.is-absolute($file) {
           # not absolute, search the metrics path for the file
           my @metrics_path = %*ENV<METRICS>:exists
             ?? %*ENV<METRICS>.split(/\:/)>>.subst(rx{'/'$},'')
             !! < /usr/lib/afm  /usr/local/lib/afm
                  /usr/openwin/lib/fonts/afm  . >;

	   for @metrics_path {
               my $candidate = $*SPEC.catfile( $_, $file);
	       if $candidate.IO ~~ :f {
		   $file = $candidate;
		   last;
	       }
	   }
       }
   }

   die "Can't find the AFM file for $name ($file)"
     unless $file.IO ~~ :e;

   my $afm = $file.IO.open( :r );

   for $afm.lines {

       if /^StartKernData/   ff /^EndKernData/ {
           next unless m:s/ <|w> KPX  $<glyph1>=['.'?\w+] $<glyph2>=['.'?\w+] $<kern>=[< + - >?\d+] /;
           $metrics<Kern>{ $<glyph1> }{ $<glyph2> } = $<kern>.Int;
       }
       next if /^StartComposites/ ff /^EndComposites/; # same for composites
       if /^StartCharMetrics/    ff /^EndCharMetrics/ {
	   # only lines that start with "C" or "CH" are parsed
	   next unless /^ C H? ' ' /;
	   my $name  = ~ m:s/ <|w> N  <('.'?\w+)> ';' /;
	   my $wx    = + m:s/ <|w> WX <(\d+)>     ';' /;
           warn "no bbox: $_"
	       unless m:s/ <|w> B [ (< + - >?\d+) ]+ ';' /;
	   my $bbox = [ @0.map: { .Int } ];
	   # Should also parse lingature data (format: L successor lignature)
	   $metrics<Wx>{$name} = $wx;
	   $metrics<BBox>{$name} = $bbox;
	   next;
       }

       last if /^EndFontMetrics/;

       if /(^\w+)' '+(.*)/ {
           my $key = ~ $0;
           my $val = ~ $1;
           $metrics{$key} = $val;
       } else {
	   die "Can't parse: $_";
       }
   }

   $afm.close;

   unless $metrics<Wx><.notdef>:exists {
       $metrics<Wx><.notdef> = 0;
       $metrics<BBox><.notdef> = [ 0, 0, 0, 0];
   }

   self.BUILD(:$metrics);
}

multi submethod BUILD( Hash :$metrics! ) {
    self{.key} = .value for $metrics.pairs;
}

multi method new(Str $name)  { self.bless( :$name ) }
multi method new(Hash $metrics) { self.bless( :$metrics ) }

# Returns an 256 element latin1-ish array that maps from characters to width
multi method wx-table($enc = 'latin1') {
    self<_wx_table>{$enc} //= do {
	my @wx;
	for (0..255) {
	    my $glyph-name = $Font::Encoding::glyph{$_} // '.notdef';
            $glyph-name = '.notdef'
                if $glyph-name ~~ /^ 'control'/;
            @wx.push: self<Wx>{$glyph-name} // self<Wx><.notdef>;
	}
	@wx
    };
}

method stringwidth( Str $string, Numeric $pointsize?, :$enc='latin1', Bool :$kern) {
    my $width = 0.0;
    my $prev-glyph;
    my $kern-tab = self.Kern if $kern;
    for $string.ords {
        my $glyph-name = $Font::Encoding::glyph{$_} // '.notdef';
        my $glyph-width = self<Wx>{$glyph-name} // self<Wx><.notdef>;
	$width += $glyph-width;

        $width += $kern-tab{$prev-glyph}{$glyph-name}
           if $kern && $prev-glyph && ($kern-tab{$prev-glyph}{$glyph-name}:exists);

        $prev-glyph = $glyph-name;
    }
    if ($pointsize) {
	$width *= $pointsize / 1000;
    }
    $width;
}

method !is-prop($prop-name) {
    BEGIN constant KnownProps = set < FontName FullName FamilyName Weight
    ItalicAngle IsFixedPitch FontBBox UnderlinePosition
    UnderlineThickness Version Notice Comment EncodingScheme
    CapHeight XHeight Ascender Descender Wx BBox Kern>;
    $prop-name ∈ KnownProps;
}

multi method FALLBACK(Str $prop-name where self!"is-prop"($prop-name)) {
    self.WHAT.^add_method($prop-name, { self{$prop-name} } );
    self."$prop-name"();
}

multi method FALLBACK($name) is default { die "unknown method: $name\n" }


