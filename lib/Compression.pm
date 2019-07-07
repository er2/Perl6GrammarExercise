# https://techdevguide.withgoogle.com/paths/advanced/compress-decompression#

use v6;

unit module Compression;

grammar Compression {
   token TOP       { <term>+ }
   token term      { <letters> | <letterset> }
   token letterset { <number>? '[' <TOP>? ']' }
   token letters   { <[a..z]>+ }
   token number    { \d+ }
}

class Decompress {
         method TOP($/)                     { make [~] $<term>.map: *.made }
   multi method term($/ where $<letters>)   { make $<letters>.made }
   multi method term($/ where $<letterset>) { make $<letterset>.made }
         method letterset($/)               { make ($<TOP>.made // "") x +($<number> // 0) }
         method letters($/)                 { make ~$/ }
}

sub parse($corpus) is export {
   Compression.parse($corpus, actions => Decompress.new).made;
}

my @examples = "3[a]","3[abc]4[ab]c","a[]b";

for @examples -> $example {
   say "$example => {parse($example)}";
}
