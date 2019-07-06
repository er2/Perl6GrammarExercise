# https://techdevguide.withgoogle.com/paths/advanced/compress-decompression#

use v6;

unit module Compression;

grammar Compression {
   token TOP { <term>+ }
   token term { [<letters> | <compressed>] }
   token compressed { <emptybrackets> | <letterset> }
   token letterset { [ <number> \[ <TOP> \] ] }
   token letters { <[a..z]>+ }
   token number { \d+ }
   token emptybrackets { \[\] }
}

class Decompress {
   method TOP($/) { make [~] $<term>.map: *.made }
   method term($/) { make ($<letters> // $<compressed>).made }
   method compressed($/) { make ($<emptybrackets> // $<letterset>).made }
   method letterset($/) { make $<TOP>.made x +$<number> }
   method letters($/) { make ~$/ }
   method emptybrackets($/) { "" }
}

sub parse($corpus) is export {
   Compression.parse($corpus, actions => Decompress.new).made;
}

my @examples = "3[a]","3[abc]4[ab]c", "a[]b";

for @examples -> $example {
   say "$example => {parse($example)}";
}
