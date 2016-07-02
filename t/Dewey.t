#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;
use Test::Deep;
use DDG::Test::Goodie;

zci answer_type => 'dewey_decimal';
zci is_cached => 1;

sub build_structured_answer
{
	my ($data) = @_;
    return $data, structured_answer => {
        id => "dewey_decimal",
        name => "Answer",
        templates => {
            group => 'list',
            options => {
                content => 'record',
                moreAt => 0
            }
        },
        data => {
            title => "Dewey Decimal System",
            record_data => $data
        }
    };
}

ddg_goodie_test(
	[qw(
		DDG::Goodie::Dewey
	)],
	"dewey 123" => test_zci(build_structured_answer({
        "123" => "Determinism and indeterminism"
    })),
	'646 dewey decimal system' => test_zci(build_structured_answer({
        "646" => "Sewing, clothing, personal living"
    })),
    'dewey decimal system 640s' => test_zci(build_structured_answer({
        "641" => "Food & drink",
        "642" => "Meals & table service",
        "643" => "Housing & household equipment",
        "644" => "Household utilities",
        "645" => "Household furnishings",
        "646" => "Sewing, clothing, personal living",
        "647" => "Management of public households",
        "648" => "Housekeeping",
        "649" => "Child rearing & home care of sick"
    }))
	#'dewey decimal system 640s' => test_zci("", html => '<table cellpadding=1><tr><td>641</td><td>&nbsp;<a href="/?q=Food">Food</a> & <a href="/?q=drink">drink</a></td></tr><tr><td>642</td><td>&nbsp;<a href="/?q=Meal">Meal</a>s & table service</td></tr><tr><td>643</td><td>&nbsp;<a href="/?q=House">Housing</a> & household equipment</td></tr><tr><td>644</td><td>&nbsp;<a href="/?q=Household">Household</a> utilities</td></tr><tr><td>645</td><td>&nbsp;<a href="/?q=Furniture">Household furnishings</a></td></tr><tr><td>646</td><td>&nbsp;<a href="/?q=Sewing">Sewing</a>, <a href="/?q=clothing">clothing</a>, personal living</td></tr><tr><td>647</td><td>&nbsp;<a href="/?q=Household management">Management of public household</a>s</td></tr><tr><td>648</td><td>&nbsp;<a href="/?q=Household chore">Housekeeping</a></td></tr><tr><td>649</td><td>&nbsp;<a href="/?q=Child rearing">Child rearing</a> & <a href="/?q=home care">home care</a> of sick</td></tr></table>'),
    #'#1 in the dewey decimal system' => test_zci("001 is knowledge in the Dewey Decimal System.", html => '001 is <a href="/?q=outline of knowledge">knowledge</a> in the Dewey Decimal System.'),
    #'dewey decimal system naturalism' => test_zci("146 is naturalism and related systems in the Dewey Decimal System.", html => '146 is <a href="/?q=naturalism (philosophy)">naturalism</a> and related systems in the Dewey Decimal System.'),
    #'etymology in the dewey decimal system' => test_zci("", html => re(qr{^<table cellpadding=1>.*</table>$})),
    #'dewey 644' => test_zci('644 is household utilities in the Dewey Decimal System.', html => '644 is <a href="/?q=household">household</a> utilities in the Dewey Decimal System.'),
);

done_testing;
