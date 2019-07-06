use v6;

use lib 'lib';

use Test;

use-ok 'Compression';

use Compression;

is parse("3[a]"), "aaa";

is parse("3[abc]4[ab]c"), "abcabcabcababababc";

plan 3;
