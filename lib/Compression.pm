# https://techdevguide.withgoogle.com/paths/advanced/compress-decompression#

use v6;

unit module Compression;

grammar Compression {
   token TOP { <term>+ }
   token term { [<letters> | <compressed>] }
   token compressed { <number> \[ <letters> \] }
   token letters { <[a..z]>+ }
   token number { \d+ }
}

class Decompress {
   method TOP($/) { make [~] $<term>.map: *.made }
   method term($/) { make ($<letters> // $<compressed>).made }
   method compressed($/) { make $<letters>.made x +$<number> }
   method letters($/) { make ~$/ }
}

sub parse($corpus) is export {
   Compression.parse($corpus, actions => Decompress.new).made;
}

my @examples = "3[a]","3[abc]4[ab]c";

for @examples -> $example {
   say "$example => {parse($example)}";
}
