-module(numerals).
-export([calc_numeral/3,
	 calc_numeral/1]).

calc_numeral(N) ->
    calc_numeral(N, "" , 1).

calc_numeral(0, StrNumeral, _) ->
    StrNumeral;

calc_numeral(N, StrNumeral, C) ->
    L = [{1000, "M"}, {900, "CM"}, {500, "D"},{400, "CD"}, {100, "C"},{90, "XC"},{50, "L"},{40, "XL"},{10, "X"}, {9, "IX"},{5, "V"},{4, "IV"},{1, "I"}],
    {X, Y} = lists:nth(C, L),
    Diff = N - X,
    if Diff >= 0  ->
	    calc_numeral(Diff, string:concat(StrNumeral, Y), 1);
       true -> 
	    calc_numeral(N, StrNumeral, C + 1)
    end.