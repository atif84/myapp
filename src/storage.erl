-module(storage).

-export([new/0,
         add/3,
         delete/2,
         find/2,
         is_defined/2,
         find_even/1,
         print_x/1,
         reminder/1,
         find_even_tail_recursive/1,
         find_even_tail_recursive/2,
         element_of_list_in_tuple/1]).

new() ->
    [].

add(Key, Value, Storage) ->
    [{Key, Value} | Storage].

delete(Key, Storage) ->
    delete(Key, Storage, []).

delete(_, [], Res) ->
    Res;
delete(Key, [{Key, _} | Storage], Acc) ->
    delete(Key, Storage, Acc);
delete(Key, [Pair | Storage], Acc) ->
    delete(Key, Storage, [Pair | Acc]).

find(Key, Storage) ->
    %% [{K, V} || {K, V} <- Storage, K == Key].
    [Pair || Pair <- Storage, element(1, Pair) == Key].


is_defined(Key, Storage) ->
    proplists:is_defined(Key, Storage).

%% find even number from a list - normal recursive
find_even([])->
    [];
find_even([H|T])->
    case H rem 2 == 0 of
        true ->
            [H|find_even(T)] ;
        false ->
            find_even(T)
    end.

print_x(X) ->
    X.

reminder(N) -> N rem 2.

%% find even number from a list - tail recursive
find_even_tail_recursive(N) ->
    find_even_tail_recursive(N,[]).

find_even_tail_recursive([],Acc) ->
    Acc;

find_even_tail_recursive([H|T],Acc) ->
    case H rem 2 == 0 of
        true ->
            find_even_tail_recursive(T,[H|Acc]);
        false ->
            find_even_tail_recursive(T,Acc)
    end.

%% Pattern matching list within tuple
element_of_list_in_tuple(L) ->
    %%L = [{input_packets,122},{output_packets,33},{input_packets,123},{input_packets,152}],
    [ Value || {Packet,Value}<-L , Packet==input_packets].
