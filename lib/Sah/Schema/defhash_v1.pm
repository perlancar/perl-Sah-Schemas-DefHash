package Sah::Schema::defhash_v1;

# AUTHORITY
# DATE
# DIST
# VERSION

our $schema = ['defhash', {
    summary => 'DefHash v1',
    keys => {
        defhash_v => ['int', {req=>1, is=>1}, {}],
    },
}];

1;
# ABSTRACT:
