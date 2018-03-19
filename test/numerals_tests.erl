-module(numerals_tests).
-include_lib("eunit/include/eunit.hrl").

convert_numeral_test() ->
    N = numerals:calc_numeral(999),
    ?assertEqual("CMXCIX", N).
    
convert_numeral_for_substruction_rule_test() ->
    N = numerals:calc_numeral(9),
    ?assertEqual("IX", N).
