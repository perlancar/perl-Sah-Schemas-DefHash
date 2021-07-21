package Sah::Schema::defhash;

# AUTHORITY
# DATE
# DIST
# VERSION

use strict;
use warnings;

use Regexp::Pattern::DefHash;

our $schema = [hash => {
    summary => 'DefHash',
    'allowed_keys_re' => $Regexp::Pattern::DefHash::RE{key}{pat},
    keys => {

        v         => ['float', {req=>1, default=>1}],

        defhash_v => ['int', {req=>1, default=>1}],

        name      => ['str', {
            req=>1,
            clset => [
                {
                    match             => '\A\w+\z',
                    'match.err_level' => 'warn',
                    'match.err_msg'   => 'should be a word',
                },
                {
                    max_len             => 32,
                    'max_len.err_level' => 'warn',
                    'max_len.err_msg'   => 'should be short',
                },
            ],
            'clset.op' => 'and',
        }],

        caption   => ['str', {req=>1}],

        summary   => ['str', {
            req => 1,
            clset => [
                {
                    max_len             => 72,
                    'max_len.err_level' => 'warn',
                    'max_len.err_msg'   => 'should be short',
                },
                {
                    'match'           => qr/\n/,
                    'match.op'        => 'not',
                    'match.err_level' => 'warn',
                    'match.err_msg'   => 'should only be a single-line text',
                },
            ],
            'clset.op' => 'and',
        }],

        description => ['str', {req => 1}],

        tags => ['array', {
            of => ['any', {
                req => 1,
                of => [
                    ['str', {req=>1}],
                    ['hash', {req=>1}], # XXX defhash
                ],
            }],
        }],

        default_lang => ['str', {
            req => 1,
            match => '\A[a-z]{2}(_[A-Z]{2})?\z',
        }, {}],

        x => ['any', {
        }, {}],
    },
    'keys.restrict' => 0,

    examples => [
        {value=>{}, valid=>1},
        {value=>{foo=>1, bar=>1}, valid=>1},
        {value=>{"foo-bar"=>1}, valid=>0, summary=>"Invalid property syntax, contains dash"},
    ],
}];

# XXX check known attributes (.alt, etc)
# XXX check alt.XXX format (e.g. must be alt\.(lang\.\w+|env_lang\.\w+)
# XXX *.alt.*.X should also be of the same type (e.g. description.alt.lang.foo

1;
# ABSTRACT:
