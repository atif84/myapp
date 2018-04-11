-module(game).
-export([calc_score/1,calc_score/2,inputformatter/1,replace_symbol_to_int/1,replace_symbol_to_int/2]).

calc_score(L) ->
    calc_score(L, 0).

calc_score([], Score) -> 
    Score;

calc_score([N], Score) -> 
    Score + N;

calc_score([N, NN] , Score) -> 
    Score + N + NN;

calc_score([N, NN, NNN | Tail] , Score) ->
    Diff=10-NN,
    case N of 
 	10 ->
	    calc_score([NN, NNN | Tail] , Score + 10 + NN + NNN);
        Diff -> 
	    calc_score([NNN | Tail], Score + 10 + NNN);
	_ -> 
	    calc_score([NN, NNN | Tail], Score + N)   	
    end.

inputformatter(S) ->
    L = lists:map(fun(X) -> [X] end, S),
    replace_symbol_to_int([O || O <- L, O /= "|", O /= "||"]).

replace_symbol_to_int(L) ->
    replace_symbol_to_int(L, []).

replace_symbol_to_int([], L) ->
    lists:reverse(L);

replace_symbol_to_int([H | T], L) ->
    case H of 
	"X" ->
	    replace_symbol_to_int(T, [10 | L]);
	"/" ->
	    Int=lists:nth(1,L),
	    replace_symbol_to_int(T, [(10 - Int) | L]);
	"-" ->
	    replace_symbol_to_int(T, [0 | L]);
	_ ->
	    {Int1, _}=string:to_integer(H),
            replace_symbol_to_int(T, [Int1 | L])
    end.
