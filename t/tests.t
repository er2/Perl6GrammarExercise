use v6;

use lib 'lib';

use Test;

# use-ok fatal;

use-ok 'Compression';

use Compression;

is parse("abc"), "abc";

is parse("3[a]"), "aaa";

is parse("3[abc]4[ab]c"), "abcabcabcababababc";

is parse("0[abc]"), "";

is parse("a[]b"), "ab";

is parse("2[3[a]b]"), "aaabaaab";

plan 7;
