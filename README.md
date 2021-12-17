[![Actions Status](https://github.com/pdf-raku/Font-AFM-raku/workflows/test/badge.svg)](https://github.com/pdf-raku/Font-AFM-raku/actions)

Name
----

Font::AFM - Interface to Adobe Font Metrics files

Synopsis
--------

    use Font::AFM;
    my Font::AFM $h .= core-font: 'Helvetica';
    my $copyright = $h.Notice;
    my $w = $h.Wx<aring>;
    $w = $h.stringwidth("Gisle", 10);

Description
-----------

This module implements the Font::AFM class. Objects of this class are initialised from an AFM (Adobe Font Metrics) file and allow you to obtain information about the font and the metrics of the various glyphs in the font.

This module includes built-in metrics classes for the 14 PDF Core Fonts.

Metrics can also be loaded for local AFM files on your system.

All measurements in AFM files are given in terms of units equal to 1/1000 of the scale factor of the font being used. To compute actual sizes in a document, these amounts should be multiplied by (scale factor of font)/1000.

### Font Metrics Classes

This module includes built-in classes for the 14 PDF Core Fonts. For example:

    use Font::Metrics::helvetica;
    my $bbox = Font::Metrics::helvetica.FontBBox;

The list of PDF Core Fonts is:

  * Courier Fonts

    * Font::Metrics::courier

    * Font::Metrics::courier-bold

    * Font::Metrics::courier-oblique

    * Font::Metrics::courier-boldoblique

  * Helvetica Fonts

    * Font::Metrics::helvetica

    * Font::Metrics::helvetica-bold

    * Font::Metrics::helvetica-oblique

    * Font::Metrics::helvetica-boldoblique

  * Times-Roman Fonts

    * Font::Metrics::times-roman

    * Font::Metrics::times-bold

    * Font::Metrics::times-italic

    * Font::Metrics::times-bolditalic

  * Symbolic Fonts

    * Font::Metrics::symbol

    * Font::Metrics::zapfdingbats

Methods
-------

### method core-font

```perl6
method core-font(
    Str $font-name
) returns Font::AFM:D
```

Loads a named PDF core font

Where `$font-name` is one of `Helvetica`, `Helvetica-Bold`, `Helvetica-Oblique`, `Helvetica-Boldoblique`, `Times-Roman`, `Times-Bold`, `Times-Italic`, `Times-BoldItalic`, `Symbol`, or `Zapfdingbats` (case insensitive).

### my $afm = Font::AFM.new: :$name;

AFM font metrics loader. `:$name` may be the absolute path of a font. Otherwise the font is loaded from the directory specified by the `METRICS` environment variable (see ENVIRONMENT below). Croaks if the font can not be found.

### $afm.FontName

The name of the font as presented to the PostScript language `findfont` operator, for instance "Times-Roman".

### $afm.FullName

Unique, human-readable name for an individual font, for instance "Times Roman".

### $afm.FamilyName

Human-readable name for a group of fonts that are stylistic variants of a single design. All fonts that are members of such a group should have exactly the same `FamilyName`. Example of a family name is "Times".

### $afm.Weight

Human-readable name for the weight, or "boldness", attribute of a font. Examples are `Roman`, `Bold`, `Light`.

### $afm.ItalicAngle

Angle in degrees counterclockwise from the vertical of the dominant vertical strokes of the font.

### $afm.IsFixedPitch

If `true`, the font is a fixed-pitch (monospaced) font.

### $afm.FontBBox

An array of integers giving the lower-left x, lower-left y, upper-right x, and upper-right y of the font bounding box in relation to its origin. The font bounding box is the smallest rectangle enclosing the shape that would result if all the characters of the font were placed with their origins coincident, and then painted.

### $afm.KernData

A two dimensional hash containing from and to glyphs and kerning widths.

### $afm.UnderlinePosition

Recommended distance from the baseline for positioning underline strokes. This number is the y coordinate of the center of the stroke.

### $afm.UnderlineThickness

Recommended stroke width for underlining.

### $afm.Version

Version number of the font.

### $afm.Notice

Trademark or copyright notice, if applicable.

### $afm.Comment

Comments found in the AFM file.

### $afm.EncodingScheme

The name of the standard encoding scheme for the font. Most Adobe fonts use the `AdobeStandardEncoding`. Special fonts might state `FontSpecific`.

### $afm.CapHeight

Usually the y-value of the top of the capital H.

### $afm.XHeight

Typically the y-value of the top of the lowercase x.

### $afm.Ascender

Typically the y-value of the top of the lowercase d.

### $afm.Descender

Typically the y-value of the bottom of the lowercase p.

### $afm.Wx

Returns a hash table that maps from glyph names to the width of that glyph.

### $afm.BBox

Returns a hash table that maps from glyph names to bounding box information in relation to each glyph's origin. The bounding box consist of four numbers: llx, lly, urx, ury.

### $afm.stringwidth($string, $fontsize?, :kern, :%glyphs)

Returns the width of the string passed as argument. The string is assumed to contains only characters from `%glyphs`. A second argument can be used to scale the width according to the font size.

### ($kerned, $width) = $afm.kern($string, $fontsize?, :%glyphs?)

Kern the string. Returns an array of string segments, separated by numeric kerning distances, and the overall width of the string.

    :%glyphs            - an optional mapping of characters to glyph-names.

SEE ALSO
--------

  * [Font::FreeType](Font::FreeType) - To obtain metrics (and more) for many other font formats , including`*.pfa`, `*.pfm`, `*.ttf` and `*.otf` files.

  * [HarfBuzz](HarfBuzz) - Also has some ability to obtain metrics for `*.ttf` and `*.otf` fonts.

### method metrics-class

```perl6
method metrics-class(
    Str $font-name
) returns Font::AFM:U
```

autoloads the appropriate delegate for the named font. A subclass of Font::AFM

The AFM specification can be found at:

    http://partners.adobe.com/asn/developer/pdfs/tn/5004.AFM_Spec.pdf

ENVIRONMENT
===========

  * *METRICS*

    Contains the path to search for AFM-files. Format is as for the PATH environment variable. The default path built into this library is:

        /usr/lib/afm:/usr/local/lib/afm:/usr/openwin/lib/fonts/afm/:.

BUGS
====

Composite character and Ligature data are not parsed.

COPYRIGHT
=========

Copyright 1995-1998 Gisle Aas. All rights reserved.

Ported from Perl to Raku by David Warring Copyright 2015

This program is free software; you can redistribute it and/or modify it under the same terms as Perl itself.

