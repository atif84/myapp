-module(erlang_exercises).
-export([exercise_01/1,
                 exercise_02/1,
                 exercise_03/1,
                 exercise_04/1,
                 exercise_05/1,
                 exercise_06/2,
                 recurssion/1,
				 exercise_07/2,
		 		 exercise_08/2,
                 add_one_tail_recurssion/1
                ]).

exercise_01(Input_tuple) ->
        tuple_to_list(Input_tuple).

exercise_02(L) ->
        [ X+1 || X <- L ].

exercise_03(L) ->
        [ X || X <- L, X rem 2 == 0 ]. 

%%% should try using partition to avoid double loop check partition/2 {satisfying condition, unsatified list}
exercise_04(L) ->
        {[ X || X <- L, X rem 2 == 0 ],
         [ X || X <- L, X rem 2 /= 0 ]}.

%%% check if the string is palindrome 
exercise_05(Mystring) ->
        L = string:tokens(Mystring, " "),
        [ X || X <- L, lists:reverse(X) == X ].

%%% return total number of charater count the given string
exercise_06(Char, String)->
        length([X || X <- String, X == Char]).

%%% write 06 in a recursive
%%% add 1 in the given list using recursion
recurssion([])->
        [];
recurssion([H|T]) ->  
                [H+1|recurssion(T)].

%%% add 1 in a list using tail recursive.
add_one_tail_recurssion(L) ->
        add_one_tail_recurssion(L,[]).

add_one_tail_recurssion([],Acc) ->
        Acc; 

add_one_tail_recurssion([H|T],Acc) ->
        lists:reverse(add_one_tail_recurssion(T,[H+1|Acc])).

exercise_07(X, L) ->
    case lists:member(X, L) of
        false ->
            [X|L];
        true ->
            L
    end.

exercise_08(E, L) ->
    case lists:member(E, L) of
        false ->
            L ++ [E];
        true  ->
            L
    end.



