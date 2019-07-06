use v6;

use lib 'lib';

use Test;

use-ok 'Compression';

use Compression;

is parse("3[a]"), "aaa";

is parse("3[abc]4[ab]c"), "abcabcabcababababc";

is parse("0[abc]"), "";

is parse("a[]b"), "ab";

plan 5;
